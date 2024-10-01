import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/profile.dart';
import 'package:info91/src/modules/profile/controllers/user_profile_controller.dart';
import 'package:info91/src/widgets/custom/app_app_bar.dart';
import 'package:info91/src/widgets/custom/app_group_tile.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/custom/app_popup_menu_button.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class UserProfilePage extends StatelessWidget {
  UserProfilePage({super.key});

  static const routeName = '/user_profile';

  final _controller = Get.find<UserProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Column(
        children: [
          const AppAppBar(
              disableActionPadding: true,
              leadingPadding: 10,
              leading: Text(
                'Profile',
                style: TextStyle(
                  fontSize: AppFontSizes.small15,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              showSearch: false,
              action: Row(
                children: [
                  AppPopupMenuButton(
                    children: [
                      AppPopupMenuItem(
                        title: 'Share',
                      ),
                      AppPopupMenuItem(
                        title: 'Edit',
                      ),
                    ],
                  ),
                  SizedBox(
                    width: AppSpacings.small10,
                  )
                ],
              )),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                vertical: AppPaddings.xLarge,
              ),
              children: [
                ..._buildProfile(),
                const SizedBox(
                  height: AppSpacings.small10,
                ),
                _buildAbout(),
                const SizedBox(
                  height: AppSpacings.small10,
                ),
                ..._buildMediaAndDocs(),
                const SizedBox(
                  height: AppSpacings.small,
                ),
                ..._buildGroups(),
                _buildBlockButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildProfile() {
    return [
      Obx(() {
        return AppCircleImage(
          radius: 60,
          image: _controller.profileImageUrl.value,
        );
      }),
      const SizedBox(
        height: AppSpacings.small,
      ),
      Obx(() {
        return Text(
          _controller.name.value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: AppFontSizes.xLarge,
            fontWeight: FontWeight.w600,
          ),
        );
      }),
      const SizedBox(
        height: AppSpacings.xxSmall2,
      ),
      Row(
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPaddings.xxxSmall4,
            ),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20)),
            child: Obx(() {
              return Text(
                _controller.number.value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: AppFontSizes.small15,
                ),
              );
            }),
          ),
          const SizedBox(
            width: AppSpacings.xSmall / 2,
          ),
          Expanded(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: AppInkWell(
                    borderRadius: 16,
                    onTap: _controller.onCopy,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSpacings.xSmall / 2),
                      child: AppSvgAsset(
                        'assets/images/ic_copy.svg',
                        color: AppColors.text,
                        width: 17,
                      ),
                    ),
                  )))
        ],
      ),
      const SizedBox(
        height: AppSpacings.small10,
      ),
      Obx(() {
        return Text(
          _controller.status.value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: AppFontSizes.xxxSmall,
          ),
        );
      }),
    ];
  }

  Widget _buildAbout() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPaddings.large,
      ),
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppSpacings.small16,
          ),
          const Text(
            'About',
            style: TextStyle(
              fontSize: AppFontSizes.small15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: AppSpacings.small14,
          ),
          Obx(() {
            return Text(
              _controller.about.value,
              style: const TextStyle(
                fontSize: AppFontSizes.small15,
              ),
            );
          }),
          Row(
            children: [
              const Expanded(
                child: SizedBox(
                  height: AppSpacings.xMedium,
                ),
              ),
              Obx(() {
                return Text(
                  _controller.aboutDate.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: AppFontSizes.xxxSmall,
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMediaAndDocs() {
    return [
      _buildListTitle('Media, Docs and Links'),
      const SizedBox(
        height: AppSpacings.xSmall,
      ),
      SizedBox(
        height: 76,
        child: ListView.builder(
          itemCount: 10,
          padding: const EdgeInsets.symmetric(
            horizontal: AppPaddings.large,
          ),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
            width: 76,
            color: Colors.primaries[index],
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildGroups() {
    return [
      _buildListTitle('Groups'),
      const SizedBox(
        height: AppSpacings.xSmall,
      ),
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPaddings.large,
          vertical: AppPaddings.xSmall,
        ),
        color: AppColors.white,
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return AppGroupTile(Profile.dummyList()[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: AppSpacings.small,
          ),
          itemCount: 2,
        ),
      ),
    ];
  }

  Widget _buildBlockButton() {
    return AppInkWell(
      onTap: _controller.onBlockChatPressed,
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.large,
          vertical: AppPaddings.xLarge,
        ),
        child: Row(
          children: [
            AppSvgAsset('assets/images/ic_block.svg'),
            SizedBox(
              width: AppSpacings.xxSmall,
            ),
            Text(
              'Block this user',
              style: TextStyle(
                fontSize: AppFontSizes.small15,
                color: AppColors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPaddings.large,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: AppFontSizes.small15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
