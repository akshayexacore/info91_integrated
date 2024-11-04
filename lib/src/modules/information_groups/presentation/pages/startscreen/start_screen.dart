import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';

import 'package:info91/src/modules/information_groups/presentation/profile_section/profile_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/startscreen/start_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_scaffold.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/expandable_widget.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/icon.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/profile_top_image_sec.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';

class StartScreen extends StatelessWidget {
  static const routName = "/startScreen";
  StartScreen({Key? key}) : super(key: key);
  final StarScreenController controller = Get.put(StarScreenController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScaffold(
        children: [
          Obx(() {
            return CustomAppBar(
              imageUrl: controller.responseModel.value.profileImage,
              appBarName: "Lorem Ipsum",
            );
          }),
          Obx(() {
            return ProfileTopImageSec(
              isProfile: false,
              backGroundImage: controller.responseModel.value.coverImage ?? "",
              profileImage:
                  "https://s3-alpha-sig.figma.com/img/35e8/9d9d/e5b9d1d23149590ef05ef35d5019c1af?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qqj9NDxLQ62C0Qg6~MQQSZ5GaRk~u1~DGuRCFkGIyzxIl9ro~QiH7sKpqES3Vfh2Vz5rHPZZq-Xrq9vaz840HBavPUgmr34V3lTXCeUFze9Sg1lXyvkmXSqqyfDnQiJegGLhcnDZP30ip7Wo77D-YFZhJlDKg58UjFcyr80mbwpErKO0YaT-ndZOroyuXHDiH6oBJwj-odwRH55Vlaaj5TTraPFHMchFJhJ1dv6atYIIwFyukiF2HplWCzSrtwLJZtWY9DxPb-WNP37NSQTFOROBZ-lwJv7svxE7zMkQWeD5lLjhxTWUGCMMqCwGnHVouLxxO8E0Y5CD~z1db~6aeQ__",
            );
          }),
          Expanded(child: Obx(() {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: marginWidth),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      greyBoldText(
                          controller.responseModel.value.groupName ?? "",
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                          size: 16.sp),
                      Spacer(),
                      clickebleIcon("assets/images/youtube.svg", () {controller.launchURL( controller.responseModel.value.youtubeLink??"");}),
                      SizedBox(
                        width: 20.w,
                      ),
                      clickebleIcon("assets/images/world.png", () {controller.launchURL( controller.responseModel.value.websiteLink??"");}),
                      SizedBox(
                        width: 20.w,
                      ),
                      clickebleIcon("assets/images/map.png", () {controller.launchURL( controller.responseModel.value.googleMapLink??"");}),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  greyContentText(
                    "${controller.responseModel.value.memberCount ?? ""} members",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ExpandableTextWidget(
                      text: controller.responseModel.value.purpose ?? ""),
                  SizedBox(
                    height: 15.h,
                  ),
                  greyBoldText("Banners",
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                      size: 15.sp),
                  SizedBox(
                    height: 15.h,
                  ),
                  BannersImageView(
                      imageList: controller.responseModel.value.banners ??
                          []) // Spacer()
                ],
              ),
            );
          })),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: marginWidth),
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: "Contact",
                    // isBorder: true,
                    busy: false,
                    onPressed: () {},
                    style: AppButtonStyles.appButton.copyWith(
                        backgroundColor:
                            WidgetStatePropertyAll(AppColors.white)),
                    textStyle: AppTextStyles.appButton
                        .copyWith(color: AppColors.black),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: AppButton(
                    text: controller.selectedChatModel?.joinedGroupFlag == false
                        ? "Join Group"
                        : 'Message',
                    busy: false,
                    onPressed: () {
                      controller.joinMessageTapFunc();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => ChatScreen(),
                      //     ));
                    },
                    style: AppButtonStyles.appButton.copyWith(
                        backgroundColor: WidgetStatePropertyAll(
                      AppColors.secondary,
                    )),
                    textStyle: AppTextStyles.appButton
                        .copyWith(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
