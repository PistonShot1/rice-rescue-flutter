import 'package:flutter/material.dart';
import 'package:vhack_client/model/chat_entity.dart';
import 'package:vhack_client/presentation/components/image/mynetwork_image.dart';

import '../../../../shared/constant/custom_color.dart';
import '../../../../shared/constant/custom_textstyle.dart';

class ChatCard extends StatelessWidget {
  final ChatEntity eachChat;
  ChatCard({super.key, required this.eachChat});

  @override
  Widget build(BuildContext context) {
    bool isUser = eachChat.chatRole == 'user';

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isUser
              ? CustomColor.getSecondaryColor(context)
              : CustomColor.getPrimaryColor(context)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: eachChat.chatContent == 'system'
                  ? CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(
                        eachChat.chatRole == 'system'
                            ? 'assets/image.jpg'
                            : 'assets/resumegambar.jpg',
                      ),
                    )
                  : const MyNetworkImage(
                      pathURL:
                          'https://firebasestorage.googleapis.com/v0/b/vhack-rice-rescue.appspot.com/o/user%2F66222aac3f4946d069fac1dd%2FWhatsApp%20Image%202024-04-19%20at%2017.18.16.jpeg?alt=media&token=70e9b4e2-c68d-4e9d-97d4-47d1a466c24b',
                      width: 50,
                      height: 50,
                      radius: 60)),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  eachChat.chatRole == 'system' ? 'System' : 'User',
                  style: CustomTextStyle.getTitleStyle(
                      context,
                      15,
                      isUser
                          ? CustomColor.getWhiteColor(context)
                          : CustomColor.getTertieryColor(context)),
                ),
                Text(
                  eachChat.chatContent!,
                  style: CustomTextStyle.getSubTitleStyle(
                      context,
                      15,
                      isUser
                          ? CustomColor.getWhiteColor(context)
                          : CustomColor.getTertieryColor(context)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
