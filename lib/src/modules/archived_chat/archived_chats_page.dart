import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/home/controllers/chats_controller.dart';
import 'package:info91/src/widgets/custom/app_app_bar.dart';
import 'package:info91/src/widgets/custom/app_message_profile_tile.dart';
import 'package:info91/src/widgets/custom/app_popup_menu_button.dart';

class ArchivedChatsPage extends StatelessWidget {
  ArchivedChatsPage({super.key});

  static const routeName = '/archived_chats';

  final _controller = ChatsController.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.offWhite,
        body: Column(
          children: [
            AppAppBar(
              leadingLeftPadding: false,
              disableActionPadding: true,
              titleWidget: const Text(
                'Archived Chats',
                style: TextStyle(
                  fontSize: AppFontSizes.small15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              action: Row(
                children: [
                  AppPopupMenuButton(
                    children: [
                      AppPopupMenuItem(
                        title: 'Restore Chats',
                        onPressed: _controller.onRestoreArchivedChats,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemBuilder: (context, index) {
                    return Obx(() {
                      return AppMessageProfileTile(
                        _controller.archivedChats[index],
                        selected: _controller
                                .selectedArchiveChatIndexes.isNotEmpty
                            ? _controller.selectedArchiveChatIndexes
                                .contains(_controller.archivedChats[index].id)
                            : null,
                        onLongPress: _controller
                                .selectedArchiveChatIndexes.isEmpty
                            ? () {
                                _controller.onArchiveProfileLongPressed(index);
                              }
                            : null,
                        onPressed: () {
                          if (_controller
                              .selectedArchiveChatIndexes.isNotEmpty) {
                            _controller.onArchiveProfilePressed(index);
                          } else {
                            _controller
                                .gotoChatPage(_controller.archivedChats[index]);
                          }
                        },
                      );
                    });
                  },
                  itemCount: _controller.archivedChats.length,
                );
              }),
            ),
          ],
        ));
  }
}
