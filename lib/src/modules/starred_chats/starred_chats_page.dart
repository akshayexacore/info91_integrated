import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/starred_chats/controllers/starred_chats_controller.dart';
import 'package:info91/src/modules/starred_chats/controllers/starred_message_tile.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/custom/app_popup_menu_button.dart';
import 'package:info91/src/widgets/tiny/app_back_button.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class StarredChatsPage extends StatelessWidget {
  StarredChatsPage({super.key});

  static const routeName = '/starred';

  final _controller = Get.find<StarredChatsController>();

  @override
  Widget build(BuildContext context) {
    final bool canPop = ModalRoute.of(context)?.canPop ?? false;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _controller.onBackPressed();
      },
      child: Scaffold(
        backgroundColor: AppColors.offWhite,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          iconTheme: const IconThemeData(
            color: AppColors.white,
          ),
          automaticallyImplyLeading: false,
          leadingWidth: 0,
          titleSpacing: 10,
          title: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildPrimaryAppBar(canPop: canPop, key: UniqueKey())),
        ),
        body: Obx(() {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: AppPaddings.medium16,
            ),
            itemBuilder: (context, index) =>
                LayoutBuilder(builder: (context, constraints) {
              return Obx(() {
                return StarredChatMessageTile(
                  chat: _controller.chats[index],
                  selected: _controller.selectedChatIndexes
                      .contains(_controller.chats[index].id),
                  onLongPress: () {
                    _controller.onChatLongPressed(index);
                  },
                  onPressed: _controller.selectedChatIndexes.isNotEmpty
                      ? () {
                          _controller.onChatPressed(index);
                        }
                      : null,
                );
              });
            }),
            itemCount: _controller.chats.length,
          );
        }),
      ),
    );
  }

  Widget _buildPrimaryAppBar({
    required bool canPop,
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
            onPressed: _controller.onBackPressed,
          ),
          const SizedBox(
            width: 15,
          ),
        ],
        const Text(
          'Starred messages',
          style: TextStyle(
            fontSize: AppFontSizes.small15,
            color: AppColors.white,
          ),
        ),
        const Spacer(),
        Obx(() {
          return _buildOption(
            _controller.containsOnlyStarredMessage.isTrue
                ? 'ic_star_outline.svg'
                : 'ic_star.svg',
            onPressed: _controller.onStarPressed,
          );
        }),
        AppPopupMenuButton(
          children: [
            AppPopupMenuItem(
              title: 'Unstar all ',
              onPressed: _controller.onUnStarAllPressed,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOption(
      String s, {
        VoidCallback? onPressed,
      }) {
    return AppInkWell(
      borderRadius: 24,
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(
          AppPaddings.small / 2,
        ),
        child: SizedBox(
            height: 24,
            width: 24,
            child: Center(
                child: AppSvgAsset(
                  'assets/images/$s',
                  color: AppColors.white,
                ))),
      ),
    );
  }
}
