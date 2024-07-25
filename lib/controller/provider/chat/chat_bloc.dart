import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vhack_client/controller/service/chat/chat_service.dart';
import 'package:vhack_client/model/chat_entity.dart';
import 'package:vhack_client/shared/constant/custom_string.dart';

part 'chat_event.dart';
part 'chat_state.dart';

String promptAI =
    'You are an expert in the application for paddy give the information that related to this disease';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatLoaded(chatHistory: [])) {
    on<ChatGenerateNewTextMessageEvent>(chatGenerateNewTextMessageEvent);
  }

  bool isLoading = false;

  List<ChatEntity> chatHistory = [
    ChatEntity(chatRole: "system", chatContent: CustomString.promptAI)
  ];

  final chat = ChatService();
  Future<void> chatGenerateNewTextMessageEvent(
      ChatGenerateNewTextMessageEvent event, Emitter<ChatState> emit) async {
    isLoading = true;
    chatHistory
        .add(ChatEntity(chatRole: 'user', chatContent: event.inputMessage));
    emit(ChatLoaded(chatHistory: chatHistory));
    final chatResponse = await chat.addChat(event.inputMessage, chatHistory);

    if (chatResponse == '') {
      chatHistory.add(ChatEntity(
          chatRole: 'system', chatContent: 'Something was error with request'));
    } else {
      chatHistory
          .add(ChatEntity(chatRole: 'system', chatContent: chatResponse));
    }

    emit(ChatLoaded(chatHistory: chatHistory));
    isLoading = false;
  }
}
