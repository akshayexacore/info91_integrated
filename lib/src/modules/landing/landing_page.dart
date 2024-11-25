import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/coming_new_screen.dart';

import 'package:info91/src/modules/home/home_page.dart';
import 'package:info91/src/modules/landing/controllers/landing_controller.dart';

import 'package:info91/src/widgets/custom/app_app_bar.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/custom/app_popup_menu_button.dart';

import 'package:info91/src/widgets/tiny/image_view.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  static const routeName = '/landing';

  final _controller = LandingController.get();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _controller.onBackPressed();

        return true; // Prevents the default back navigation
      },
      child: Scaffold(
        body: Column(
          children: [
            _buildPrimaryAppBar(),
            Expanded(
              child: PageView(
                controller: _controller.tabController,
                onPageChanged: _controller.onPageChanged,
                children: [
                  HomePage(),
                  const ComingSoonPage(
                    appBarName: "",
                    content:
                        " A new feature is on the way to enhance your chat experience with the latest trends and insights. Stay tuned for more!",
                    isAppBAr: false,
                  ),
                  const ComingSoonPage(
                    appBarName: "",
                    content:
                        " A new feature is on the way to keep your groups updated with the latest trends and insights right in the app. Stay tuned for more!",
                    isAppBAr: false,
                  ),
                  const ComingSoonPage(
                    appBarName: "",
                    content:
                        "A new feature is on the way to keep your status updates fresh and engaging with the latest trends and insights. Stay tuned for more!",
                    isAppBAr: false,
                  ),

                  // ChatsPage(),
                  // GroupsPage(),
                  // StatusPage(),
                  // Container(
                  //   color: Colors.white,
                  // )
                ],
              ),
            ),
          ],
        ),
        // floatingActionButton: Obx(() {
        //   if (_controller.enabledFab) {
        //     return AppInkWell(
        //       borderRadius: 100,
        //       onTap: _controller.gotoContactSelect,
        //       child: Container(
        //         height: 50,
        //         width: 50,
        //         margin: const EdgeInsets.only(bottom: 10),
        //         decoration: BoxDecoration(
        //             color: AppColors.white,
        //             boxShadow: [
        //               BoxShadow(
        //                   offset: const Offset(0, 4),
        //                   blurRadius: 4,
        //                   spreadRadius: 0,
        //                   color: Colors.black.withOpacity(0.25))
        //             ],
        //             borderRadius: BorderRadius.circular(100)),
        //         child: const Center(
        //           child: AppSvgAsset(
        //             'assets/images/ic_new_message.svg',
        //             height: 25,
        //             width: 25,
        //           ),
        //         ),
        //       ),
        //     );
        //   }
        //   return const SizedBox();
        // }),
        bottomNavigationBar: Obx(() {
          return Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.white,
              currentIndex: _controller.currentIndex.value,
              showUnselectedLabels: true,
              selectedItemColor: AppColors.secondary,
              unselectedItemColor: AppColors.text,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              onTap: _controller.onBottomNavigationTap,
              items: [
                BottomNavigationBarItem(
                  icon: AppSvgAsset(
                    'assets/images/ic_home.svg',
                    color: _controller.currentIndex.value == 0
                        ? AppColors.secondary
                        : AppColors.text,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: AppSvgAsset(
                    'assets/images/ic_chats.svg',
                    color: _controller.currentIndex.value == 1
                        ? AppColors.secondary
                        : AppColors.text,
                  ),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: AppSvgAsset(
                    'assets/images/ic_groups.svg',
                    color: _controller.currentIndex.value == 2
                        ? AppColors.secondary
                        : AppColors.text,
                  ),
                  label: 'Groups',
                ),
                BottomNavigationBarItem(
                  icon: AppSvgAsset(
                    'assets/images/ic_status.svg',
                    color: _controller.currentIndex.value == 3
                        ? AppColors.secondary
                        : AppColors.text,
                  ),
                  label: 'Status',
                ),
                // BottomNavigationBarItem(
                //   icon: AppSvgAsset(
                //     'assets/images/ic_services_dark.svg',
                //     color: _controller.currentIndex.value == 4
                //         ? AppColors.secondary
                //         : AppColors.text,
                //   ),
                //   label: 'Services',
                // ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPrimaryAppBar() {
    return Obx(() {
      return AppAppBar(
        disableActionPadding: true,
        leadingLeftPadding: false,
        // leading: _controller.enableChatSelection.isFalse
        //     ? const SizedBox(
        //         height: 31,
        //         width: 31,
        //         child: AppCircleImage(
        //           image:
        //               'https://shotkit.com/wp-content/uploads/2021/06/cool-profile-pic-matheus-ferrero.jpeg',
        //         ),
        //       )
        //     : AppBackButton(
        //         color: AppColors.white,
        //         onPressed: _controller.onBackPressed,
        //       ),
        titleWidget: _controller.enableChatSelection.isFalse
            ? const AppAssetImage(
                'assets/images/appbar_logo.png',
                height: 26,
              )
            : Text(
                '${_controller.selectedProfileCount.value} chat selected',
                style: const TextStyle(
                  fontSize: AppFontSizes.small15,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
        action: _controller.enableChatSelection.isFalse
            ? _buildPrimaryAppBarAction(
                onContactPressed: _controller.gotoContactSelect,
              )
            : _buildSelectedAppBarAction(),
      );
    });
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

  Widget _buildPrimaryAppBarAction({VoidCallback? onContactPressed}) {
    return Row(
      children: [
        // AppInkWell(
        //   onTap: onContactPressed,
        //   child: const AppSvgAsset(
        //     'assets/images/ic_contact_book.svg',
        //     color: AppColors.white,
        //   ),
        // ),
        // const SizedBox(
        //   width: 16,
        // ),
        // AppInkWell(
        //   onTap: () {},
        //   child: const AppSvgAsset(
        //     'assets/images/ic_bell.svg',
        //     color: AppColors.white,
        //   ),
        // ),
        // const SizedBox(
        //   width: 16,
        // ),
     AppPopupMenuButton(
            children: [
              // AppPopupMenuItem(
              //   title: _controller.enableChatSelection.isTrue
              //       ? 'Clear Selection'
              //       : 'Select Chats',
              //   icon: 'ic_select_chat.svg',
              //   onPressed: () {
              //     _controller.onChatSelectionSelected(
              //         _controller.enableChatSelection.isFalse);
              //   },
              // ),
              // AppPopupMenuItem(
              //   title: 'Starred Messages',
              //   icon: 'ic_starred_message.svg',
              //   onPressed: _controller.gotoStarredMessages,
              // ),
              // AppPopupMenuItem(
              //   title: 'Archive Chats',
              //   icon: 'ic_archive.svg',
              //   onPressed: _controller.onArchiveChat,
              // ),
              // AppPopupMenuItem(
              //   title: 'Broadcast list',
              //   icon: 'ic_broadcast_list.svg',
              //   onPressed: () {},
              // ),
              AppPopupMenuItem(
                title: 'Settings',
                icon: 'ic_settings_small.svg',
                onPressed: _controller.gotoSettings,
              ),
            ],
          ),
     
        const SizedBox(
          width: 10,
        )
      ],
    );
  }

  Widget _buildSelectedAppBarAction() {
    return Row(
      children: [
        _buildOption(
          'ic_archive_fill.svg',
          onPressed: _controller.onArchiveChat,
        ),
        _buildOption(
          'ic_delete_fill.svg',
          onPressed: _controller.onDeletePressed,
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
