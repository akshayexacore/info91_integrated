import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/chat.dart';
import 'package:info91/src/modules/chat/controllers/chat_controller.dart';
import 'package:info91/src/modules/chat/grouped_list.dart';
import 'package:info91/src/widgets/custom/app_app_bar.dart';
import 'package:info91/src/widgets/custom/app_emoji_picker.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/custom/app_popup_menu_button.dart';
import 'package:info91/src/widgets/custom/build_appbar_widgets.dart';
import 'package:info91/src/widgets/custom/chat_input_widget.dart';
import 'package:info91/src/widgets/custom/chat_message_tile.dart';
import 'package:info91/src/widgets/tiny/app_back_button.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  static const routeName = '/chat';

  final _controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    final bool canPop = ModalRoute.of(context)?.canPop ?? false;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _controller.onBackPressed();
      },
      child: Obx(() {
        return Scaffold(
          backgroundColor: AppColors.offWhite,
          body: Column(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _controller.selectedChatIndexes.isEmpty
                    ? _buildPrimaryAppBar(
                        canPop: canPop, key: const Key('_buildPrimaryAppBar'))
                    : _buildSelectedAppBar(
                        canPop: canPop,
                        key: const Key('_buildSelectedAppBar'),
                        selectedCount:
                            _controller.selectedChatIndexes.length.toString()),
              ),
              Expanded(
                child: Obx(() {
                  debugPrint(_controller.chats.isEmpty.toString());
                  return GroupedList<Chat, DateTime>(
                    controller: _controller.scrollController,
                    elements: _controller.chats,
                    groupBy: (element) => element.date,
                    groupComparator: (value1, value2) =>
                        value1.compareTo(value2),
                    groupHeaderBuilder: (index) => Column(
                      children: [
                        const SizedBox(
                          height: AppSpacings.small10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppPaddings.xSmall,
                            vertical: AppPaddings.xxxSmall4,
                          ),
                          child: Text(
                            DateFormat("MMM dd, yyyy")
                                .format(_controller.chats[index].date),
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: AppSpacings.small10,
                        ),
                      ],
                    ),
                    indexedItemBuilder: (context, index) => ChatMessageTile(
                      chat: _controller.chats[index],
                      selected: _controller.selectedChatIndexes
                          .contains(_controller.chats[index].id),
                      onLongPress: (Offset position) {
                        _controller.onChatLongPressed(index, position);
                      },
                      onPressed: _controller.selectedChatIndexes.isNotEmpty
                          ? () {
                              _controller.onChatPressed(index);
                            }
                          : null,
                    ),
                  );
                }),
              ),
              Obx(() {
                debugPrint(_controller.replyChat.value.id.toString());
                return ChatInputWidget(
                  controller: _controller.textEditingControllerChat,
                  onEmojiPressed: _controller.showHideEmoji,
                  focusNode: _controller.focusNode,
                  onAttachmentsPressed: _controller.showHideAttachments,
                  showReply: _controller.replyChat.value.id != 0,
                  onCloseReply: _controller.onCloseReply,
                  replyMessage: _controller.replyChat.value.message,
                );
              }),
              Obx(() {
                return _controller.showEmoji.isTrue
                    ? SizedBox(
                        height: 350,
                        child: AppEmojiPicker(
                            _controller.textEditingControllerChat),
                      )
                    : const SizedBox();
              }),
              Obx(() {
                return _controller.showAttachments.isTrue
                    ? _buildAttachmentsMenu(
                        onGalleryPressed: () {},
                        onContactPressed: () {},
                        onDocPressed: () {},
                        onNavigationPressed: () {})
                    : const SizedBox();
              }),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildPrimaryAppBar({
    required bool canPop,
    Key? key,
  }) {
    return AppAppBar(
      showSearch: false,
      autoImplyLeading: false,
      leadingLeftPadding: false,
      leadingPadding: 10,
      leading: Row(
        children: [
          if (canPop) ...[
            AppBackButton(
              color: AppColors.white,
              onPressed: _controller.onBackPressed,
            ),
            const SizedBox(
              width: 15,
            ),
          ],
          AppInkWell(
            borderRadius: 100,
            onTap: _controller.gotoProfile,
            child: const Row(
              children: [
                AppCircleImage(
                  radius: 22,
                  image:
                      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Arya',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    if (true)
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
              ],
            ),
          ),
        ],
      ),
      disableActionPadding: true,
      action: Row(
        children: [
          AppPopupMenuButton(
            children: [
              AppPopupMenuItem(
                title: 'Clear chat',
                onPressed: _controller.onClearPressed,
              ),
              AppPopupMenuItem(
                title: 'Contact info',
                onPressed: () {},
              ),
              AppPopupMenuItem(
                title: 'Block chat',
                onPressed: _controller.onBlockChatPressed,
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  Widget _buildSelectedAppBar(
      {required bool canPop, Key? key, required String selectedCount}) {
    return AppAppBar(
      showSearch: false,
      leadingLeftPadding: false,
      leadingPadding: 10,
      leading: Row(
        children: [
          AppBackButton(
            color: AppColors.white,
            onPressed: _controller.onBackPressed,
          ),
          const SizedBox(
            width: 15,
          ),

          Text(selectedCount,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          // if (true)
          //   Text(
          //     'Online',
          //     style: TextStyle(
          //       color: AppColors.greenAccent,
          //       fontSize: AppFontSizes.xxxSmall,
          //     ),
          //   ),

          // const SizedBox(
          //   width: 8,
          // ),
          // Container(
          //   width: 1,
          //   color: AppColors.white,
          //   height: 20,
          // ),
        ],
      ),
      autoImplyLeading: false,
      action: Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildOption(
            'ic_forward.svg',
            onPressed: _controller.onForwardPressed,
          ),
          Obx(() {
            if (!_controller.selectedMoreThanOne) {
              return buildOption(
                'ic_reply.svg',
                onPressed: _controller.onReplyPressed,
              );
            }
            return const SizedBox();
          }),
          buildOption(
            'ic_content_copy.svg',
            onPressed: _controller.onCopyPressed,
          ),
          Obx(() {
            return buildOption(
              _controller.containsOnlyStarredMessage.isTrue
                  ? 'ic_star_outline.svg'
                  : 'ic_star.svg',
              onPressed: _controller.onStarPressed,
            );
          }),
          buildOption(
            'ic_delete.svg',
            onPressed: _controller.onDeletePressed,
          ),
          Obx(() {
            if (!_controller.selectedMoreThanOne &&
                _controller.chats
                    .firstWhere((element) =>
                        element.id == _controller.selectedChatIndexes.first)
                    .own) {
              return buildOption(
                'ic_info.svg',
                onPressed: _controller.onInfoPressed,
              );
            }
            return const SizedBox();
          }),
        ],
      ),
    );
  }

  Widget _buildAttachmentsMenu({
    VoidCallback? onGalleryPressed,
    VoidCallback? onDocPressed,
    VoidCallback? onNavigationPressed,
    VoidCallback? onContactPressed,
  }) {
    return Container(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: AppPaddings.large,
          left: AppPaddings.large,
          right: AppPaddings.large,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildAttachmentsMenuOption(
                onPressed: onGalleryPressed,
                icon: 'ic_image.svg',
                label: 'Gallery'),
            _buildAttachmentsMenuOption(
                onPressed: onDocPressed, icon: 'ic_doc.svg', label: 'Document'),
            _buildAttachmentsMenuOption(
                onPressed: onNavigationPressed,
                icon: 'ic_navigation.svg',
                label: 'Location'),
            _buildAttachmentsMenuOption(
                onPressed: onContactPressed,
                icon: 'ic_contact.svg',
                label: 'Contacts'),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentsMenuOption({
    VoidCallback? onPressed,
    required String icon,
    required String label,
  }) {
    return Column(
      children: [
        AppInkWell(
          borderRadius: 54,
          onTap: onPressed,
          child: Container(
              height: 54,
              width: 54,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(54)),
              child: AppSvgAsset(
                'assets/images/$icon',
              )),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          label,
          style: AppTextStyles.app12SB,
        )
      ],
    );
  }
}
