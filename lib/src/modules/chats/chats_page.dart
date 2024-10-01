import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/home/controllers/chats_controller.dart';
import 'package:info91/src/modules/landing/controllers/landing_controller.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/custom/app_message_profile_tile.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class ChatsPage extends StatelessWidget {
  ChatsPage({super.key});

  final _controller = ChatsController.get();

  final _landingController = LandingController.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      extendBody: true,
      body: Obx(() {
        return ListView.builder(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemBuilder: (context, realIndex) {
            if (realIndex >= _controller.recentChats.length + 1) {
              return const SizedBox(
                height: AppSpacings.xxLarge50,
              );
            }
            if (realIndex == 0) {
              return _controller.archivedChats.isNotEmpty
                  ? _buildArchiveButton(
                      onPressed: _controller.gotoArchivedChats)
                  : const SizedBox();
            }

            int index = realIndex - 1;
            return Obx(() {
              return AppMessageProfileTile(
                _controller.recentChats[index],
                selected: _controller.selectedChatIndexes.isNotEmpty ||
                        _landingController.enableChatSelection.isTrue
                    ? _controller.selectedChatIndexes
                        .contains(_controller.recentChats[index].id)
                    : null,
                onLongPress: _controller.selectedChatIndexes.isEmpty
                    ? () {
                        _controller.onProfileLongPressed(index);
                      }
                    : null,
                onPressed: () {
                  if (_controller.selectedChatIndexes.isNotEmpty ||
                      _landingController.enableChatSelection.isTrue) {
                    _controller.onProfilePressed(index);
                  } else {
                    _controller.gotoChatPage(_controller.recentChats[index]);
                  }
                },
              );
            });
          },
          itemCount: _controller.recentChats.length + 2,
        );
      }),
    );
  }

  Widget _buildArchiveButton({VoidCallback? onPressed}) {
    return AppInkWell(
      onTap: onPressed,
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.large,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppPaddings.mediumX,
              ),
              child: Row(
                children: [
                  Center(
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: AppSvgAsset('assets/images/ic_archive.svg'),
                    ),
                  ),
                  SizedBox(
                    width: AppSpacings.small16,
                  ),
                  Text(
                    'Archived chats',
                    style: TextStyle(
                      fontSize: AppFontSizes.small15,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: AppColors.white,
              height: 1,
            )
          ],
        ),
      ),
    );
  }
}
