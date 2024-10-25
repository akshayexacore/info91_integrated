import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/informationgroup/information_group.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_avatarwithimageicon.dart';
import 'package:info91/src/widgets/custom/image_view.dart';

class ChatListItem extends StatelessWidget {
  final InfoGroupChatListModel chat;
  final Function onTap;
  const ChatListItem({super.key, required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
  radius: 25.0,
  backgroundImage: chat.profileImage != null && chat.profileImage!.isNotEmpty
      ? NetworkImage(chat.profileImage!)
      : null,
  child: chat.profileImage == null || chat.profileImage!.isEmpty
      ? Icon(Icons.person, size: 30.0)
      : FadeInImage.assetNetwork(
          placeholder: 'assets/placeholder.png', // Path to your placeholder image
          image: chat.profileImage!,
          imageErrorBuilder: (context, error, stackTrace) => Icon(Icons.person, size: 30.0), // Icon on error
          fit: BoxFit.cover,
        ),
),
      title: Text(
        chat.groupName??"",
        style: const TextStyle(fontWeight: FontWeight.bold),maxLines: 1,
      ),
      subtitle: Text(
        "chat.message",
        style: const TextStyle(
            color: Colors.black, overflow: TextOverflow.ellipsis,),maxLines: 1,
      ),
      trailing: Column(
        children: [
          Text(
            chat.lastSendTime??'',
            style: const TextStyle(color: Colors.black, fontSize: 12.0),
          ),
          // if (chat.itemcount != 0 && chat.itemcount != null) ...[
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
          // ]
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
        leading: buildContactAvatar(avatar, contactName),
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
        onTap: onCange);
  }
}
