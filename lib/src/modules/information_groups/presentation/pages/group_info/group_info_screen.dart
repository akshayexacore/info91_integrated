import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/group_info/group_info_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/startscreen/start_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_popupmenu.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/new_input_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/utils/app_validator.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GroupInfo extends StatelessWidget {
  static const routeName = '/group_info';
  GroupInfo({super.key});
  Widget commonGap = SizedBox(
    height: 15.h,
  );
  final controller = Get.put(GroupInfpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return CustomAppBar(
              appBarName: "Group Info",
              actionWidget: [
                if (controller.dataModel.value.isAdmin == true)
                  customTextButton("Save", onTap: () {
                    print("ontap");
                    controller.updateInfoData();
                  }),
              ],
            );
          }),
          Expanded(
            child: Obx(() {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: marginWidth),
                  child: Skeletonizer(
                    enabled: controller.isLoading.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.dataModel.value.isAdmin == true &&
                            !controller.isNonEdit.value) ...[
                          commonGap,
                          blusHeading("Contact Details"),
                          commonGap,
                          NewInputCard(
                            controller: controller.mobileNumberController,
                            title: "Mobile Number",
                            keyType: TextInputType.phone,
                             suffixIcon: Icons.call,
                            ontap: () {
                              controller.saveContact(
                                  controller.mobileNumberController.text);
                            },
                          ),
                          commonGap,
                          NewInputCard(
                            controller:
                                controller.alterNativeMobileNumberController,
                            keyType: TextInputType.phone,
                            title: "Alternative Number",
                          ),
                          // commonGap,
                          // NewInputCard(
                          //   controller: controller.whatsappNumberController,
                          //   title: "Whatsapp Number",
                          //   keyType: TextInputType.phone,
                          // ),
                          commonGap,
                          blusHeading("Timings and Holidays"),
                          commonGap,
                          NewInputCard(
                            controller: controller.contactTimeController,
                            title: "Contact Time",
                          ),
                          commonGap,
                          NewInputCard(
                            controller: controller.holidaysController,
                            title: "Holidays",
                          ),
                          commonGap,
                          blusHeading("Others"),
                          commonGap,
                          NewInputCard(
                            controller: controller.websiteLinkController,
                            title: "Website link",
                            isLink: true,
                             suffixIcon:Icons.visibility,
                            ontap: () {
                              controller.launchURL(
                                  controller.websiteLinkController.text);
                            },
                          ),
                          commonGap,
                          NewInputCard(
                            controller: controller.youtubeLinkController,
                            title: "Youtube link",
                            isLink: true,
                            suffixIcon:Icons.visibility,
                            ontap: () {
                              controller.launchURL(
                                  controller.youtubeLinkController.text);
                            },
                          ),
                          commonGap,
                          NewInputCard(
                            controller:
                                controller.googleMapControllerController,
                            title: "Google map link",
                            isLink: true,
                             suffixIcon: Icons.visibility,
                            ontap: () {
                              controller.launchURL(controller
                                  .googleMapControllerController.text);
                            },
                          ),
                          commonGap,
                        ] else ...[
                          commonGap,
                          blusHeading("Contact Details"),
                          commonGap,
                          groupInfoDoubleText("Mobile Number",
                              controller.mobileNumberController.text,
                              onTap: () {
                            controller.saveContact(
                                controller.mobileNumberController.text);
                          }),
                          groupInfoDoubleText(
                              "Alternative Number",
                              controller
                                  .alterNativeMobileNumberController.text),
                          // groupInfoDoubleText("Whatsapp Number",
                          //     controller.whatsappNumberController.text),
                          blusHeading("Timings and Holidays"),
                          commonGap,
                          groupInfoDoubleText("Contact Time",
                              controller.contactTimeController.text),
                          groupInfoDoubleText(
                              "Holidays", controller.holidaysController.text),
                          blusHeading("Others"),
                          commonGap,
                          groupInfoDoubleText("Website link",
                              controller.websiteLinkController.text, onTap: () {
                            controller.launchURL(
                                controller.websiteLinkController.text);
                          }),
                          groupInfoDoubleText("Youtube link",
                              controller.youtubeLinkController.text, onTap: () {
                                if(controller.youtubeLinkController.text.trim().isNotEmpty){
                               
                                    controller.launchURL(
                                controller.youtubeLinkController.text);
                                }
                          
                          }),
                          groupInfoDoubleText("Google map link",
                              controller.googleMapControllerController.text,
                              onTap: () {
                                if(  controller.googleMapControllerController.text.trim().isNotEmpty){
                                    controller.launchURL(
                                controller.googleMapControllerController.text);
                                }
                          
                          }),
                        ],
                        commonGap,
                      ],
                    ),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Widget groupInfoDoubleText(String heading, String content,
      {Function? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        greyContentText(heading),
        SizedBox(
          height: 8.h,
        ),
        InkWell(
            onTap: () {
              if (onTap != null) {
                onTap!();
              }
            },
            child: greyBoldText(content, fontWeight: FontWeight.w400)),
        SizedBox(
          height: 15.h,
        ),
      ],
    );
  }
}
