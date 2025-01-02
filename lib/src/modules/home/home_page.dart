import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/coming_new_screen.dart';
import 'package:info91/src/modules/home/controllers/chats_controller.dart';
import 'package:info91/src/modules/home/controllers/home_controller.dart';
import 'package:info91/src/modules/home/widgets/category_icon.dart';

import 'package:info91/src/modules/information_groups/presentation/pages/info_chatlist/inform_group_chatlist_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';

import 'package:info91/src/widgets/custom/app_message_profile_tile.dart';
import 'package:info91/src/widgets/custom/image_view.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final ChatsController _chatsController = ChatsController.get();
  final HomeController _controller = HomeController.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: AppPaddings.xLarge,
            ),
            _buildCategoriesCard(context),
            const SizedBox(
              height: AppPaddings.xLarge,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPaddings.large,
              ),
              child: Text(
                'Recent chats',
                style: TextStyle(
                  fontSize: AppFontSizes.small,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPaddings.large,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppSvgAsset(
                    'assets/images/coming_soon.svg',
                    width: 65,
                    height: 65,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 20.h,),
                  greynonBoldText(
                    "Stay tuned! Your recent chats will appear here once this feature goes live."
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesCard(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(
        horizontal: AppPaddings.large,
      ),
      decoration: BoxDecoration(
          color: AppColors.offWhite,
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                color: AppColors.black.withOpacity(0.1),
                spreadRadius: 5)
          ],
          borderRadius: BorderRadius.circular(AppRadii.xSmall),
          border: Border.all(color: AppColors.homeCategoriesBorder)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: AppPaddings.small,
              left: AppPaddings.small,
              bottom: AppPaddings.xSmall,
            ),
            child: Text(
              'Categories',
              style: TextStyle(
                fontSize: AppFontSizes.small,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPaddings.xSmall),
            child: Table(
              children: [
                TableRow(children: [
                  CategoryIcon(
                    assetIcon: 'ic_information.svg',
                    title: 'Information',
                    onPressed: () {
                      print("Akshayr");
                      Get.to(() => const InfoGroupChatListScreen());
                    },
                  ),
                  CategoryIcon(
                    assetIcon: 'ic_special_info.svg',
                    title: 'Special\ninformation',
                    onPressed: () {
                      Get.to(() => const ComingSoonPage(
                            appBarName: "Special Information",
                            content:
                                "Stay informed. Something special is coming your way soon!",
                          ));
                    },
                  ),
                  CategoryIcon(
                    assetIcon: 'ic_offers.svg',
                    title: 'Offers and info',
                    onPressed: () {
                           Get.to(() => const ComingSoonPage(
                            appBarName: "Offers\nand info",
                            content:
                                "Stay informed. Something special is coming your way soon!",
                          ));
                    },
                  ),
                  CategoryIcon(
                    assetIcon: 'ic_emergency.svg',
                    title: 'Emergency alarm',
                         onPressed: () {
                           Get.to(() => const ComingSoonPage(
                            appBarName: "Emergency alarm",
                            content:
                                "Stay informed. Something special is coming your way soon!",
                          ));
                    },
                    // onPressed: _controller.onEmergencyAlarmPressed,
                  ),
                ]),
                const TableRow(children: [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
                TableRow(children: [
                  CategoryIcon(
                    assetIcon: 'ic_news.svg',
                    title: 'News',
                    onPressed: () {
                      Get.to(() => const ComingSoonPage(
                            appBarName: "'News",
                            content:
                                "Exciting news! A new feature is on the way to keep you updated with the latest trends and insights right in the app. Stay tuned for more!",
                          ));
                    },
                  ),
                  CategoryIcon(
                    assetIcon: 'ic_find_location.svg',
                    title: 'Find\nLocation',
                    onPressed: () {
                      Get.to(() => const ComingSoonPage(
                            appBarName: "Find Location",
                            content:
                                "Find Location is on the way! Soon you'll be able to search and navigate with ease right in the app.",
                          ));
                    },
                  ),
                  CategoryIcon(
                    assetIcon: 'ic_services_dark.svg',
                    title: 'Services',
                    clr: AppColors.secondary,
                    onPressed: () {
                      Get.to(() => const ComingSoonPage(
                            appBarName: "Services",
                            content:
                                "Exciting services are on the way! Stay tuned to access a variety of offerings directly from the app.",
                          ));
                    },
                  ),
                  CategoryIcon(
                    assetIcon: 'ic_classifieds.svg',
                    title: 'Classifieds',
                    onPressed: () {
                      Get.to(() => const ComingSoonPage(
                            appBarName: "Classifieds",
                            content:
                                "Classifieds is launching soon! Get ready to buy, sell, and connect with others right in the app.",
                          ));
                    },
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
