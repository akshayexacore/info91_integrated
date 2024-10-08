import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_arrow_button.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_avatarwithimageicon.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_popupmenu.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/new_input_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';

class EmergencyMainPage extends StatelessWidget {
  EmergencyMainPage({super.key});
  static const routeName = '/emergency_alarm_mainPage';
  var gap = SizedBox(
    height: 15.h,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                EdgeInsets.symmetric(horizontal: marginWidth, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                greyBoldText("Create Groups", color: AppColors.text),
                gap,
                CustomArrowTextbutton(
                  buttonName: "Groups",
                  onTap: () {},
                ),
                gap,
                greyBoldText("New Emergency Alarm", color: AppColors.text),
                gap,
                NewInputCard(
                  controller: TextEditingController(),
                  title: "Select Type",
                  label: "Default",
                  isBorder: true,
                ),
                SizedBox(
                  height: 15.h,
                ),
                gap,
                NewInputCard(
                  controller: TextEditingController(),
                  title: "Select Group",
                  label: "Default",
                  isBorder: true,
                ),
                SizedBox(
                  height: 15.h,
                ),
                gap,
                NewInputCard(
                  controller: TextEditingController(),
                  title: "Select Keywords",
                  label: "Default",
                  isBorder: true,
                ),
                SizedBox(
                  height: 15.h,
                ),
                NewInputCard(
                  controller: TextEditingController(),
                  title: "Message",
                  label: "Enter your message here",
                  maxLines: 3,
                  height: 90,
                  isBorder: true,
                ),        SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    greynonBoldText("Record your audio",),
                    Spacer(),
                    CustomCircleIconWidget(onCange: (){}, iconData: Icons.mic,radius: 20,backgroundClr: AppColors.primary.withOpacity(.1),iconColor: AppColors.black,)
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                AppButton(text: "Send",onPressed: (){},)
              ],
            ),
          )))
        ],
      ),
    );
  }
}
