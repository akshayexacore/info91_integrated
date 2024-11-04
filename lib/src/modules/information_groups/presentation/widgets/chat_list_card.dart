import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/informationgroup/information_group.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_avatarwithimageicon.dart';
import 'package:info91/src/widgets/custom/image_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatListItem extends StatelessWidget {
  final InfoGroupChatListModel chat;
  final Function onTap;

  const ChatListItem({super.key, required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.grey.shade200, // Optional background color for contrast
        child: ClipOval(
          child: chat.profileImage != null && chat.profileImage!.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: chat.profileImage!,
                  placeholder: (context, url) =>SizedBox(height :10,width:10,child: const  CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>const Icon(
                    Icons.group,
                    size: 30.0,
                    color: AppColors.black,
                  ),
                  fit: BoxFit.cover,
                  width: 50, // Match CircleAvatar's diameter
                  height: 50,
                )
              :const Icon(Icons.group, size: 30.0, color: AppColors.black),
        ),
      ),
      title: Text(
        chat.groupName ?? "",
        style: const TextStyle(fontWeight: FontWeight.bold),
        maxLines: 1,
      ),
      subtitle: Text(
        chat.lastmessage ?? "",
        style: const TextStyle(
          color: Colors.black,
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: 1,
      ),
      trailing: Column(
        children: [
          Text(
            chat.lastSendTime ?? '',
            style: const TextStyle(color: Colors.black, fontSize: 12.0),
          ),
          const SizedBox(height: 5),
          if (chat.unReadCount != null)
            CircleAvatar(
              radius: 13,
              backgroundColor: AppColors.primaryAccent,
              child: Text(
                chat.unReadCount ?? "",
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      onTap: () {
        onTap();
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
