import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_avatarwithimageicon.dart';
import 'package:info91/src/widgets/custom/image_view.dart';

class ChatListItem extends StatelessWidget {
  final Chat chat;
  final Function onTap;
  const ChatListItem({super.key, required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(chat.avatarUrl),
        radius: 25.0,
      ),
      title: Text(
        chat.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        chat.message,
        style: const TextStyle(
            color: Colors.black, overflow: TextOverflow.ellipsis),
      ),
      trailing: Column(
        children: [
          Text(
            chat.time,
            style: const TextStyle(color: Colors.black, fontSize: 12.0),
          ),
          if (chat.itemcount != 0 && chat.itemcount != null) ...[
            const SizedBox(
              height: 5,
            ),
            const CircleAvatar(
              radius: 13,
              backgroundColor: AppColors.primaryAccent,
              child: Text(
                "1",
                style: TextStyle(color: Colors.white),
              ),
            )
          ]
        ],
      ),
      onTap: () {
        onTap();
        // Handle tap event (e.g., navigate to chat details)
      },
    );
  }
}

class Chat {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final int? itemcount;

  Chat({
    required this.name,
    required this.message,
    required this.time,
    this.itemcount,
    required this.avatarUrl,
  });
}

class ContactListCard extends StatelessWidget {
  final Uint8List? avatar;
  final String contactName;
  final bool value;
  final VoidCallback onCange;
  final Widget? leadingWidget;
  const ContactListCard(
      {this.value = false,
      required this.onCange,
      required this.avatar,
      required this.contactName,
      this.leadingWidget});

  @override
  Widget build(BuildContext context) {
    print("cccccccccccccc$avatar");
    return ListTile(
        leading: buildContactAvatar(avatar,contactName
          
        ),
        title: Text(
          contactName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: leadingWidget ??
            CustomCircleIconWidget(
              onCange: onCange,
              backgroundClr: value ? AppColors.secondary : Color(0xffD9D9D9),
              radius: 12.5,
              iconColor: value ? AppColors.white : Colors.transparent,
            ),
        onTap: onCange
        );
  }
}
