import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/profile/profile_page.dart';
import 'package:info91/src/modules/settings/controllers/settings_controller.dart';
import 'package:info91/src/widgets/custom/app_app_bar.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/tiny/app_back_button.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  static const routeName = '/settings';

  final _controller = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Column(
        children: [
          AppAppBar(
            leadingLeftPadding: false,
            autoImplyLeading: false,
            showSearch: false,
            leadingPadding: 10,
            leading: AppBackButton(
              color: AppColors.white,
              onPressed: Get.back,
            ),
            titleWidget: const Text(
              'Settings',
              style: TextStyle(
                fontSize: AppFontSizes.small15,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: AppSpacings.xxSmall6,
                  ),
                  ..._buildProfile(),
                  const SizedBox(
                    height: AppSpacings.small10,
                  ),
                  _buildSettingsTile(
                    icon: 'ic_key.svg',
                    title: 'Account',
                    subTitle: 'Security notification, Change number',
                    onPressed: () {},
                  ),
                  _buildSettingsTile(
                    icon: 'ic_lock.svg',
                    title: 'Privacy',
                    subTitle: 'Block contacts, Last seen and online',
                    onPressed: () {},
                  ),
                  _buildSettingsTile(
                    icon: 'ic_chat.svg',
                    title: 'Chats',
                    subTitle: 'Theme, Wallpaper, Chat history',
                    onPressed: () {},
                  ),
                  _buildSettingsTile(
                    icon: 'ic_emergency_alarn_settings.svg',
                    title: 'Emergency Alarm',
                    subTitle: 'Add  recipients',
                    onPressed: () {},
                  ),
                  _buildSettingsTile(
                    icon: 'ic_notification.svg',
                    title: 'Notifications',
                    subTitle: 'Messages, services',
                    onPressed: () {},
                  ),
                  _buildSettingsTile(
                    icon: 'ic_storage.svg',
                    title: 'Storage and data',
                    subTitle: 'Network usage, Auto download',
                    onPressed: _controller.onStorageAndDataPressed,
                  ),
                  _buildSettingsTile(
                    icon: 'ic_language.svg',
                    title: 'App language',
                    subTitle: 'English (device’s language)',
                    onPressed: _controller.onLanguagePressed,
                  ),
                  _buildSettingsTile(
                    icon: 'ic_help.svg',
                    title: 'Help',
                    subTitle: 'Help center, privacy policy',
                    onPressed: () {},
                  ),
                  _buildSettingsTile(
                    icon: 'ic_invite.svg',
                    title: 'Invite a friend',
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: AppSpacings.xMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildProfile() {
    return [
      AppInkWell(
        onTap: () {
          Get.toNamed(ProfilePage.routeName);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPaddings.large,
            vertical: AppPaddings.large,
          ),
          child: Row(
            children: [
              Obx(() {
                return AppCircleImage(
                  image: _controller.profileImageUrl.value,
                  radius: 37,
                );
              }),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppSpacings.small10,
                    ),
                    Obx(() {
                      return Text(
                        _controller.name.value,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      );
                    }),
                    Obx(() {
                      return Text(
                        _controller.about.value,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      );
                    }),
                    const SizedBox(
                      height: AppSpacings.xMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: AppSpacings.medium,
              ),
              const AppSvgAsset(
                'assets/images/ic_qr.svg',
              )
            ],
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.large,
        ),
        child: Divider(
          height: 1,
          color: AppColors.white,
        ),
      ),
    ];
  }

  Widget _buildSettingsTile({
    required String icon,
    required String title,
    String subTitle = '',
    VoidCallback? onPressed,
  }) {
    return AppInkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPaddings.large,
          vertical: AppPaddings.xSmall10,
        ),
        child: Row(
          children: [
            SizedBox(
              height: 34,
              width: 34,
              child: Center(
                child: AppSvgAsset(
                  'assets/images/$icon',
                ),
              ),
            ),
            const SizedBox(
              width: AppSpacings.small10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: AppFontSizes.small15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subTitle.isNotEmpty)
                  Text(
                    subTitle,
                    style: const TextStyle(
                      fontSize: AppFontSizes.xSmall,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
