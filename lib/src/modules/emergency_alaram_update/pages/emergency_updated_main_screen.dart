import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/emergency_alaram_update/controller/main_screen_controller.dart';

import 'package:info91/src/modules/emergency_alaram_update/pages/alarm_audio_message_popup.dart';
import 'package:info91/src/modules/emergency_alaram_update/pages/alarm_history.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_arrow_button.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_avatarwithimageicon.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_popupmenu.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/new_input_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/app_message_profile_tile.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/custom/custom_divider.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';

class EmergencyUpdatedMainScreen extends StatelessWidget {
  // static const routeName = '/';
  static const routeName = '/emergency_updated_main_screen';


  EmergencyUpdatedMainScreen({super.key});
  final MainController _controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Column(
        children: [
          CustomAppBar(
            appBarName: "Emergency Alarm",
            actionWidget: [
              CustomPopupmenu(
                onSelected: (val) {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) =>
                  //           const InformGroupCreationScreen(),
                  //     ));
                },
                itemList: [
                  popupMenuModel(name: "Create Alarm Group", value: 1)
                ],
              ),
            ],
            isTextield: true,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: marginWidth, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColors.primary,
                        size: 27.sp,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Obx((){
                        return greyBoldText(_controller.locationMessage.value??"",
                            size: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.text);}
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      greyBoldText("Alert Recipient Groups",
                          color: AppColors.text, fontWeight: FontWeight.w600),
                      Spacer(),
                      Obx(() {
                        return greyBoldText(
                            "${_controller.selctedGroups.length} Group Selected",
                            size: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.text);
                      }),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Obx(() {
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: _controller.groupsList.length,
                      itemBuilder: (context, index) => Obx(() {
                        return AppAlarmProfileTile(
                          onPressed: () {
                            _controller.onArchiveProfilePressed(index);
                          },
                          selected: _controller.selctedGroups
                              .contains(_controller.groupsList[index].id),
                          imageUrl:
                              _controller.groupsList[index].imageUrl ?? "",
                          title: _controller.groupsList[index].groupName,
                          subTitle: _controller.conversionTOString(
                              _controller.groupsList[index].membersList),
                        );
                      }),
                    );
                  }),
                  customDivider(padding: const EdgeInsets.only(bottom: 0)),
                  greyBoldText("Communicationss",
                      color: AppColors.text, fontWeight: FontWeight.w600),
                  SizedBox(
                    height: 10.h,
                  ),
                  greyBoldText(
                      "Tap to send an emergency alert via voice or text.",
                      color: AppColors.text.withOpacity(.7),
                      fontWeight: FontWeight.w400,
                      size: 13.sp),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomCircleIconWidget(
                        onCange: () {
                          Get.dialog(const AlarmAudioMessagePopup(
                            heading: "Record your Audio to send your alert.",
                          ));
                        },
                        radius: 25,
                        iconData: Icons.mic,
                        iconColor: AppColors.primary,
                        iconSize: 25.sp,
                        backgroundClr: AppColors.primary.withOpacity(.1),
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      CustomCircleIconWidget(
                        onCange: () {
                          Get.dialog(AlarmTextMessagePopup());
                        },
                        radius: 25.r,
                        iconData: Icons.message,
                        iconColor: AppColors.primary,
                        iconSize: 25.sp,
                        backgroundClr: AppColors.primary.withOpacity(.1),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          )),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: marginWidth, vertical: 15.h),
            child: CustomArrowTextbutton(
                buttonName: "Alarms",
                onTap: () {
                  Get.to(() => const AlarmHistoryScreen());
                }),
          ),
        ],
      ),
    );
  }
}

class AlarmTextMessagePopup extends StatelessWidget {
  const AlarmTextMessagePopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: 350.w,
        height: 370.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(marginWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            greyBoldText(
                "Enter your message or select a keyword to send your alert.",
                fontWeight: FontWeight.w400),
            SizedBox(
              height: 15,
            ),
            NewInputCard(
              controller: TextEditingController(),
              title: "Select keywords",
              label: "Default",
            ),
            SizedBox(
              height: 15,
            ),
            NewInputCard(
              controller: TextEditingController(),
              title: "Message",
              label: "Enter your message here",
              height: 80,
              maxLines: 3,
            ),
            SizedBox(
              height: 13,
            ),
            Row(children: [
              Expanded(
                  child: AppButton(
                text: "Cancel",
                onPressed: () {},
                style: AppButtonStyles.appButton.copyWith(
                  backgroundColor:
                      WidgetStatePropertyAll(AppColors.primary.withOpacity(.1)),
                ),
                height: 40.h,
                textStyle:
                    AppTextStyles.appButton.copyWith(color: AppColors.black),
              )),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                  child: AppButton(
                text: "Send",
                onPressed: () {},
                height: 40.h,
              )),
            ])
          ],
        ),
      ),
    );
  }
}
