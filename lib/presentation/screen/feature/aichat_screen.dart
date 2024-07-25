import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vhack_client/shared/constant/custom_appbar.dart';
import 'package:vhack_client/shared/constant/custom_string.dart';
import '../../../controller/provider/chat/chat_bloc.dart';
import '../../../shared/constant/custom_color.dart';
import '../../../shared/constant/custom_snackbar.dart';
import '../../../shared/constant/custom_textstyle.dart';
import '../../components/card/chat/chat_card.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final chatBloc = ChatBloc();
  final tcChat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.getBackgroundColor(context),
      appBar: CustomAppBar.BuildMainAppBar(context, false),
      body: buildListMessage(),
    );
  }

  Widget buildListMessage() {
    return BlocConsumer<ChatBloc, ChatState>(
      bloc: chatBloc,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ChatLoaded) {
          return Column(
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: state.chatHistory.length,
                itemBuilder: (context, index) {
                  final eachChat = state.chatHistory[index];
                  if (eachChat.chatContent == CustomString.promptAI) {
                    return Container();
                  }
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChatCard(eachChat: eachChat));
                },
              )),
              buildBottom(chatBloc.isLoading)
            ],
          );
        } else {
          return Expanded(child: Container());
        }
      },
    );
  }

  Widget buildBottom(bool isLoading) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, bottom: 20),
      child: Column(
        children: [
          if (isLoading)
            CircularProgressIndicator(
              color: CustomColor.getSecondaryColor(context),
            ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: CustomColor.getPrimaryColor(context),
                  ),
                  child: TextField(
                    controller: tcChat,
                    cursorColor: CustomColor.getSecondaryColor(context),
                    decoration: InputDecoration(
                        hintText: 'Ask Some Question Here...',
                        hintStyle: CustomTextStyle.getSubTitleStyle(
                            context, 15, Colors.grey),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  if (tcChat.text.isNotEmpty) {
                    chatBloc.add(ChatGenerateNewTextMessageEvent(
                        inputMessage: tcChat.text));
                    tcChat.clear();
                  } else {
                    SnackBarUtil.showSnackBar('Please fill the input',
                        CustomColor.getSecondaryColor(context));
                  }
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomColor.getSecondaryColor(context)),
                    child: const Center(
                      child: Icon(
                        Icons.send_outlined,
                        color: Colors.white,
                      ),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
