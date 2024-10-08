import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/chat.dart';
import 'package:info91/src/modules/chat_info/controllers/chat_info_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/chat_screen/build_message_widget.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/custom/app_message_status.dart';
import 'package:info91/src/widgets/custom/app_popup_menu_button.dart';
import 'package:info91/src/widgets/custom/chat_message_tile.dart';
import 'package:info91/src/widgets/tiny/app_back_button.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class ChatInfoPage extends StatelessWidget {
  ChatInfoPage({super.key});

  static const routeName = '/chat_info';

  final _controller = Get.find<ChatInfoController>();

  @override
  Widget build(BuildContext context) {
    final bool canPop = ModalRoute.of(context)?.canPop ?? false;
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(
          color: AppColors.white,
        ),
        automaticallyImplyLeading: false,
        leadingWidth: 0,
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildPrimaryAppBar(
              canPop: canPop, key: UniqueKey(), name: "Messaeg Info"),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: AppSpacings.medium,
          ),
          Obx(() {
            if (_controller.isChatType.value) {
              return ChatMessageTile(
                chat: _controller.chat.value,
              );
            } else {
              bool isMe = _controller.chatMessage.senderId == "1";
              return Stack(
                children: [
                  Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: BuildMessageWidget(
                        isSameUser: true,
                        messageModel: _controller.chatMessage,
                      )),
                ],
              );
            }
          }),
          const SizedBox(
            height: AppSpacings.small10,
          ),
          Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
                color: AppColors.white,
                border: Border(
                    left: BorderSide(
                  color: AppColors.primary,
                  width: 5,
                ))),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPaddings.xxLarge,
              ),
              child: Column(
                children: [
                  _buildStatus(
                    type: MessageStatus.seen,
                    time: '8:02 am',
                  ),
                  const Divider(
                    color: AppColors.offWhite,
                    thickness: 2,
                  ),
                  _buildStatus(
                    type: MessageStatus.delivered,
                    time: '7:02 am',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPrimaryAppBar({
    required bool canPop,
    required String name,
    Key? key,
  }) {
    return Row(
      key: key,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (canPop) ...[
          AppBackButton(
            color: AppColors.white,
            onPressed: Get.back,
          ),
          const SizedBox(
            width: 15,
          ),
        ],
        AppInkWell(
          borderRadius: 100,
          onTap: () {},
          child: Row(children: [
            const AppCircleImage(
              radius: 22,
              image:
                  'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                if (false)
                  Text(
                    'Online',
                    style: TextStyle(
                      color: AppColors.greenAccent,
                      fontSize: AppFontSizes.xxxSmall,
                    ),
                  ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
          ]),
        ),
        const Spacer(),
        const AppPopupMenuButton(
          children: [],
        ),
      ],
    );
  }

  Widget _buildStatus({
    required MessageStatus type,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppPaddings.xSmall,
      ),
      child: Row(
        children: [
          AppMessageStatus(
            messageStatus: type,
          ),
          const SizedBox(
            width: AppSpacings.xxSmall,
          ),
          Expanded(
              child: Text(
            type == MessageStatus.seen ? 'Read' : 'Delivered',
            style: const TextStyle(
              fontSize: AppFontSizes.small15,
              fontWeight: FontWeight.w500,
            ),
          )),
          Text(
            time,
            style: const TextStyle(
              fontSize: AppFontSizes.xxxSmall,
              color: AppColors.text,
            ),
          ),
        ],
      ),
    );
  }
}
