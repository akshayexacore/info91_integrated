import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/informationgroup/information_group.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_avatarwithimageicon.dart';
import 'package:info91/src/widgets/custom/add_divider.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';
import 'package:info91/src/widgets/custom/image_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class ChatListItem extends StatelessWidget {
  final InfoGroupChatListModel chat;
  final Function onTap;
  final bool isSearch;

  const ChatListItem(
      {super.key,
      required this.chat,
      required this.onTap,
      this.isSearch = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor:
            Colors.grey.shade200, // Optional background color for contrast
        child: ClipOval(
          child: chat.profileImage != null && chat.profileImage!.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: chat.profileImage!,
                  placeholder: (context, url) => SizedBox(
                      height: 10,
                      width: 10,
                      child: const CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/images/defaultimg.png"),
                  fit: BoxFit.cover,
                  width: 50, // Match CircleAvatar's diameter
                  height: 50,
                )
              : Image.asset("assets/images/defaultimg.png"),
        ),
      ),
      title: Text(
        chat.groupName ?? "",
        style: const TextStyle(fontWeight: FontWeight.bold),
        maxLines: 1,
      ),
      subtitle: Container(
        width: double.infinity, // Constrain the row within its parent
        child: Row(
          children: [
            Flexible(
              child: Text(
                chat.lastmessage?.isMe == true
                    ? "You: "
                    : "${chat.lastmessage?.name ?? ""}: ",
                style: const TextStyle(
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
            SizedBox(width: 5),
            Flexible(
              child: Text(
                chat.lastmessage?.message ?? "",
                style: const TextStyle(
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
      trailing: Column(
        children: [
          Text(
            formatLastMessageTime(chat.lastmessage?.lastMessageTime),
            style: const TextStyle(color: Colors.black, fontSize: 12.0),
          ),
          const SizedBox(height: 5),
          if (chat.groupAprovedFlag == "approved" || isSearch == true) ...[
            if (chat.unReadCount != null)
              CircleAvatar(
                radius: 13,
                backgroundColor: AppColors.primaryAccent,
                child: Text(
                  chat.unReadCount ?? "",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ] else ...[
            Text(
              chat.groupAprovedFlag == "rejected" ? "Rejected" : "Pending",
              style: GoogleFonts.poppins(
                  color: chat.groupAprovedFlag == "rejected"
                      ? Colors.red
                      : AppColors.secondary),
            )
          ]
        ],
      ),
      onTap: () {
        if (chat.groupAprovedFlag == "approved" || isSearch == true) {
          onTap();
        } else {
          AppDialog.showToast(
              chat.groupAprovedFlag == "rejected"
                  ? "Approval rejected"
                  : "Approval pending",
              isSucess: false);
        }
      },
    );
  }

  String formatLastMessageTime(String? lastMessageTime) {
    if (lastMessageTime == null) return '';

    // Parse the provided date string
    DateTime messageDate = DateTime.parse(lastMessageTime);
    DateTime now = DateTime.now();

    // Check if it's today
    if (DateFormat('yyyy-MM-dd').format(messageDate) ==
        DateFormat('yyyy-MM-dd').format(now)) {
      return DateFormat('HH:mm').format(messageDate); // Show time
    }

    // Check if it's yesterday
    if (DateFormat('yyyy-MM-dd').format(messageDate) ==
        DateFormat('yyyy-MM-dd').format(now.subtract(Duration(days: 1)))) {
      return 'Yesterday';
    }

    // Otherwise, show the date
    return DateFormat('yyyy-MM-dd').format(messageDate);
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
  final bool isInactive;
  final String? subtitle;
  const ContactListCard(
      {this.value = false,
      required this.onCange,
      required this.avatar,
      required this.contactName,
      this.subtitle,
      this.leadingWidget,
      this.isInactive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isInactive ? AppColors.lightGrey : AppColors.transparent,
      child: Column(
        children: [
          ListTile(
              leading: buildContactAvatar(avatar, contactName),
              title: Text(
                contactName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              tileColor: isInactive
                  ? AppColors.white.withOpacity(.2)
                  : AppColors.transparent,
              subtitle: Text(
                subtitle ?? "",
                style: const TextStyle(fontWeight: FontWeight.w400),
              ),
              trailing: leadingWidget ??
                  CustomCircleIconWidget(
                    onCange: onCange,
                    backgroundClr:
                        value ? AppColors.secondary : const Color(0xffD9D9D9),
                    radius: 12.5,
                    iconColor: value ? AppColors.white : Colors.transparent,
                  ),
              onTap: () {
                if (!isInactive) {
                  onCange();
                }
              }),
          //  customDivider(),?
        ],
      ),
    );
  }
}
