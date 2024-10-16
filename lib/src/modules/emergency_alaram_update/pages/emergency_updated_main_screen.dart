import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
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
  static const routeName = '/emergency_alarm_updated_mainPage';

  const EmergencyUpdatedMainScreen({super.key});

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
                      greyBoldText("koratty, Thrissur, Kerala",
                          size: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.text),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      greyBoldText("Alert Recipient Groups",
                          color: AppColors.text, fontWeight: FontWeight.w600),
                      Spacer(),
                      greyBoldText("3 Group Selected",
                          size: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.text),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  ListView.builder(
                    shrinkWrap: true,
                     padding: EdgeInsets.zero,
                    itemCount: 4,
                    itemBuilder: (context, index) => AppAlarmProfileTile(
                      imageUrl:
                          "https://s3-alpha-sig.figma.com/img/d77a/69c7/cfd1f119cebf6e0df532c95ccd89c37c?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=fwce33YlWI3zdmJRCyu9RK4amzwifuSg34pXItR4LtFau9PiFwqRNwk2qP0oYfyQ17qfrc9nS9i~NGfvD7QvhF6UJHVCN~wblgoKqASNuiRL23BkT~GWfRotOcEGvGR~ZIUbRaL5Ao2Q0HT6yyJ8oW0Vhi~ID~ncPQwKSncazyPGagZPLDijwz6grsg6fozbYfIuim~09axIBK99icvg7rWGlBf7HLhcVweAE~0AdrHChkxCueLy--tfFjyXfPm78cNE~mOcjR2CU7hkpMS3XIPbqPn14Yv55y61UsZ8UWmTpzlQz0oy5sqmzPp8Uuyq51aU9ElTq71FevkQit9FyA__",
                      title: "Office Group",
                      subTitle: "Rahul,jack",
                    ),
                  ),
                  customDivider(padding: EdgeInsets.only(bottom: 0)),
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
                             Get.dialog(
      AlarmAudioMessagePopup());
                        },
                        radius: 25,iconData: Icons.mic,iconColor: AppColors.primary,iconSize: 25.sp,
                        backgroundClr: AppColors.primary.withOpacity(.1),
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      CustomCircleIconWidget(
                        onCange: () {
                          Get.dialog(
      AlarmTextMessagePopup());
                        },
                        radius: 25.r,
                        iconData: Icons.message,iconColor: AppColors.primary,iconSize: 25.sp,
                        backgroundClr: AppColors.primary.withOpacity(.1),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomArrowTextbutton(buttonName: "Alarms", onTap: () {



                  })
                ],
              ),
            ),
          ))
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
    
      ),child: Container(
      width: 350.w,
      height: 350.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),padding: EdgeInsets.all(marginWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            greyBoldText("Enter your message or select a keyword to send your alert.",fontWeight: FontWeight.w400),
            SizedBox(height: 15,),
            NewInputCard(controller: TextEditingController(), title: "Select keywords",label: "Default",),
            SizedBox(height: 15,),
            NewInputCard(controller: TextEditingController(), title: "Message",label: "Enter your message here",height: 90, maxLines: 3,),
              SizedBox(height: 13,),
            Row(
              children: [
                Expanded(child: AppButton(text: "Cancel",onPressed: (){},style: AppButtonStyles.appButton.copyWith(backgroundColor:WidgetStatePropertyAll(AppColors.primary.withOpacity(.1)), ),height: 40.h,textStyle: AppTextStyles.appButton.copyWith(color: AppColors.black) ,)),
                SizedBox(width: 10.w,),
                Expanded(child: AppButton(text: "Send",onPressed: (){},height: 40.h,)),
              ]
            )
            
           
            
          ],
        ),
      ),);
  }
}



class AlarmAudioMessagePopup extends StatelessWidget {
  const AlarmAudioMessagePopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
    
      ),child: Container(
      width: 350.w,
      height: 350.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),padding: EdgeInsets.all(marginWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            greyBoldText("Record your Audio to send your alert.",fontWeight: FontWeight.w400),
            SizedBox(height: 15,),
            
            Row(
              children: [
                Expanded(child: AppButton(text: "Cancel",onPressed: (){},style: AppButtonStyles.appButton.copyWith(backgroundColor:WidgetStatePropertyAll(AppColors.primary.withOpacity(.1)), ),height: 40.h,textStyle: AppTextStyles.appButton.copyWith(color: AppColors.black) ,)),
                SizedBox(width: 10.w,),
                Expanded(child: AppButton(text: "Send",onPressed: (){},height: 40.h,)),
              ]
            )
            
           
            
          ],
        ),
      ),);
  }
}

