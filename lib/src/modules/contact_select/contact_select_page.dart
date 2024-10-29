import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/contact_select/controllers/contact_select_controller.dart';
import 'package:info91/src/widgets/custom/app_app_bar.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/custom/app_popup_menu_button.dart';
import 'package:info91/src/widgets/custom/app_profile_tile.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class ContactSelectPage extends StatelessWidget {
  ContactSelectPage({super.key});

  static const routeName = '/contact_select';

  final ContactSelectController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      extendBody: true,
      body: Column(
        children: [
          AppAppBar(
              leadingLeftPadding: true,
              leading: const SizedBox(
                height: 31,
                width: 31,
                child: AppCircleImage(
                  image:
                      'https://shotkit.com/wp-content/uploads/2021/06/cool-profile-pic-matheus-ferrero.jpeg',
                ),
              ),
              titleWidget: const AppAssetImage(
                'assets/images/appbar_logo.png',
                height: 24,
              ),
              action: Row(
                children: [
                  const AppSvgAsset(
                    'assets/images/ic_contact_book.svg',
                    color: AppColors.white,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const AppSvgAsset(
                    'assets/images/ic_bell.svg',
                    color: AppColors.white,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  AppPopupMenuButton(
                    children: [
                      AppPopupMenuItem(
                        title: 'Select Chats',
                        icon: 'ic_select_chat.svg',
                        onPressed: () {},
                      ),
                      AppPopupMenuItem(
                        title: 'Starred Messages',
                        icon: 'ic_starred_message.svg',
                        onPressed: () {},
                      ),
                      AppPopupMenuItem(
                        title: 'Archive Chats',
                        icon: 'ic_archive.svg',
                        onPressed: () {},
                      ),
                      AppPopupMenuItem(
                        title: 'Broadcast list',
                        icon: 'ic_broadcast_list.svg',
                        onPressed: () {},
                      ),
                      AppPopupMenuItem(
                        title: 'Settings',
                        icon: 'ic_settings_small.svg',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              )),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPaddings.large,
                  vertical: 15,
                ),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        _buildGroupsMenu(),
                        const SizedBox(
                          height: 16,
                        ),
                        const Row(
                          children: [
                            SizedBox(
                              width: 48,
                            ),
                            Expanded(
                              child: Divider(
                                height: 1,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }
                  final key = _controller.recentChats.keys.elementAt(index - 1);
                  final profiles =
                      _controller.recentChats.values.elementAt(index - 1);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 48,
                        child: Center(
                          child: Text(
                            key,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      ...profiles
                          .map((profile) => AppProfileTile(
                                profile,
                                onPressed: () {
                                  _controller.gotoChatPage(profile);
                                },
                              ))
                          .toList()
                    ],
                  );
                },
                itemCount: _controller.recentChats.length + 1,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupsMenu() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      color: AppColors.white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildGroupsMenuItem(
                  icon: 'ic_persons.svg',
                  title: 'Contact',
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                child: _buildGroupsMenuItem(
                  icon: 'ic_person.svg',
                  title: 'Family',
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildGroupsMenuItem(
                  icon: 'ic_broadcast.svg',
                  title: 'Community',
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                child: _buildGroupsMenuItem(
                  icon: 'ic_alumni.svg',
                  title: 'Alumni',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGroupsMenuItem({
    required String icon,
    required String title,
    VoidCallback? onPressed,
  }) {
    return AppInkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(42),
              ),
              child: AppSvgAsset('assets/images/$icon'),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
