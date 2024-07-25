part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatFailure extends ChatState {
  final String failureTitle;
  ChatFailure({required this.failureTitle});
}

final class ChatLoaded extends ChatState {
  final List<ChatEntity> chatHistory;

  ChatLoaded({required this.chatHistory});
}
