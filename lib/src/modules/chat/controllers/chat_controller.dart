import 'dart:math';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/chat.dart';
import 'package:info91/src/modules/chat_info/chat_info_page.dart';
import 'package:info91/src/modules/forward/forward_page.dart';
import 'package:info91/src/modules/profile/user_profile_page.dart';
import 'package:info91/src/utils/app_utils.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';

class ChatController extends GetxController {
  final TextEditingController textEditingControllerChat =
      TextEditingController();

  final showEmoji = false.obs;

  final showAttachments = false.obs;

  final FocusNode focusNode = FocusNode();

  final chats = <Chat>[].obs;

  final selectedChatIndexes = <int>[].obs;

  final replyChat = Chat(date: DateTime.now()).obs;

  final scrollController = ScrollController();

  get selectedMoreThanOne => selectedChatIndexes.length != 1;

  OverlayEntry? _overlayEntry;

  final containsOnlyStarredMessage = true.obs;

  final emojis = const [
    Emoji('👍', 'Thumbs Up', hasSkinTone: true),
    Emoji('❤️', 'Red Heart'),
    Emoji('😂', 'Face With Tears of Joy'),
    Emoji('😭', 'Loudly Crying Face'),
    Emoji('👎', 'Thumbs Down', hasSkinTone: true),
  ];

  @override
  void onInit() {
    super.onInit();
    chats(Chat.dummyList());
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showEmoji(false);
        showAttachments(false);
      }
    });
    selectedChatIndexes.listen((selectedIds) {
      _checkForUnStarredMessagesInSelected();
    });
    scrollController.addListener(() {
      _disposeOverlayEntry();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _disposeOverlayEntry();
  }

  void _disposeOverlayEntry() {
    _overlayEntry
      ?..remove()
      ..dispose();
    _overlayEntry = null;
  }

  void gotoProfile() {
    _disposeOverlayEntry();
    Get.toNamed(UserProfilePage.routeName);
  }

  void showHideEmoji() {
    _disposeOverlayEntry();
    if (!showEmoji.value) {
      focusNode.unfocus();
    } else {
      focusNode.requestFocus();
      return;
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      showAttachments(false);
      showEmoji.toggle();
    });
  }

  void onChatLongPressed(int index, Offset position) {
    if (selectedChatIndexes.isEmpty) {
      selectedChatIndexes.add(chats[index].id);
      if (!chats[index].deleted) {
        _showOverlay(position, index);
      }
    }
  }

  void onClearSelected() {
    selectedChatIndexes.clear();
    _disposeOverlayEntry();
  }

  void onChatPressed(int index) {
    if (selectedChatIndexes.isNotEmpty) {
      if (!selectedChatIndexes.contains(chats[index].id)) {
        selectedChatIndexes.add(chats[index].id);
      } else {
        selectedChatIndexes.remove(chats[index].id);
      }
    }
    _disposeOverlayEntry();
  }

  void _showOverlay(Offset position, int index) {
    double height = 40.0;

    double dx = min(Get.mediaQuery.size.width - 180, position.dx);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned(
            top: position.dy - (height - 4),
            left: dx,
            child: SizedBox(
              height: height,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadii.medium),
                    color: AppColors.white,
                  ),
                  child: Row(
                    children: emojis
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(5),
                            child: AppInkWell(
                              borderRadius: 10,
                              onTap: () {
                                if (chats[index].reaction == e.emoji) {
                                  chats[index].reaction = '';
                                } else {
                                  chats[index].reaction = e.emoji;
                                }
                                //chats.refresh();
                                selectedChatIndexes.clear();
                                _disposeOverlayEntry();
                              },
                              child: SizedBox(
                                height: 26,
                                width: 26,
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      e.emoji,
                                      style: const TextStyle(fontSize: 26),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(Get.overlayContext!).insert(_overlayEntry!);
  }

  void onDeletePressed() {
    _disposeOverlayEntry();
    bool isAllOwn = true;
    for (int index in selectedChatIndexes) {
      for (Chat chat in chats) {
        if (chat.id == index) {
          if (!chat.own) {
            isAllOwn = false;
            break;
          }
        }
      }
    }
    AppDialog.showDialog(
      title: 'Delete selected messages?',
      primaryText: 'Delete for me',
      secondaryText: isAllOwn ? 'Delete for everyone' : null,
      tertiaryText: 'Cancel',
      arrangeButtonVertically: true,
      onPrimaryPressed: () {
        //_deleteSelected();
        Get.back();
      },
      onSecondaryPressed: () {
        //_deleteSelected();
        Get.back();
      },
      onTertiaryPressed: () {
        Get.back();
      },
    );
  }

  void _deleteSelected() {
    for (int id in selectedChatIndexes) {
      chats.removeWhere((element) => element.id == id);
    }
    selectedChatIndexes.clear();
  }

  void onBlockChatPressed() {
    AppDialog.showDialog(
      title: 'Block this contact ?',
      primaryText: 'Cancel',
      onPrimaryPressed: Get.back,
      secondaryText: 'Block',
      onSecondaryPressed: Get.back,
    );
  }

  void onClearPressed() {
    AppDialog.showDialog(
      title: 'Clear messages in chat ?',
      primaryText: 'Cancel',
      onPrimaryPressed: Get.back,
      secondaryText: 'Clear messages',
      onSecondaryPressed: () {
        chats.clear();
        Get.back();
      },
    );
  }

  void onForwardPressed() {
    _disposeOverlayEntry();
    Get.toNamed(ForwardPage.routeName)?.then((value) {
      if (value is bool && value) {
        onClearSelected();
      }
    });
  }

  void onReplyPressed() {
    _disposeOverlayEntry();
    try {
      final chat = chats.firstWhere(
        (element) => element.id == selectedChatIndexes.first,
      );
      selectedChatIndexes.clear();
      replyChat(chat);
    } catch (_) {}
  }

  void onCopyPressed() {
    _disposeOverlayEntry();
    AppUtils.showSnackBar(
      'Message copied',
      bottomPadding: 80,
    );
  }

  void onStarPressed() {
    _disposeOverlayEntry();
    for (int id in selectedChatIndexes) {
      try {
        final index = chats.indexWhere((element) => element.id == id);
        final chat = chats[index];
        chats[index] =
            chat.copyWith(starred: containsOnlyStarredMessage.isFalse);
      } catch (_) {}
    }

    selectedChatIndexes.clear();
  }

  void onInfoPressed() {
    _disposeOverlayEntry();
    final chat = chats.firstWhere(
      (element) => element.id == selectedChatIndexes.first,
    );
    Get.toNamed(
      ChatInfoPage.routeName,
      arguments: chat,
    );
  }

  void showHideAttachments() {
    _disposeOverlayEntry();
    if (!showAttachments.value) {
      focusNode.unfocus();
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      showEmoji(false);
      showAttachments.toggle();
    });
  }

  void onCloseReply() {
    _disposeOverlayEntry();
    replyChat(Chat(date: DateTime.now()));
  }

  void onBackPressed() {
    if (selectedChatIndexes.isEmpty &&
        showAttachments.isFalse &&
        showEmoji.isFalse &&
        _overlayEntry == null) {
      Get.back();
    } else {
      onClearSelected();
      hideAllPopups();
    }
  }

  void hideAllPopups() {
    showEmoji(false);
    showAttachments(false);
    _disposeOverlayEntry();
  }

  void _checkForUnStarredMessagesInSelected() {
    for (int id in selectedChatIndexes) {
      try {
        for (Chat element in chats) {
          if (element.id == id && !element.starred) {
            containsOnlyStarredMessage(false);
            return;
          }
        }
      } catch (_) {}
    }
    containsOnlyStarredMessage(true);
  }
}
