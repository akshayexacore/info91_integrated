import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_avatarwithimageicon.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_popupmenu.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/app_circle_image.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';

class EmrgencyAlrmListScreen extends StatelessWidget {
  const EmrgencyAlrmListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            appBarName: "Office Group",
            isTextield: true,
            actionWidget: [
              CustomPopupmenu(
                  onSelected: (value) {},
                  itemList: [popupMenuModel(name: "Mute", value: 1)]),
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: marginWidth, vertical: 20.h),
              child: Column(
                children: [
                  Container(
                    // height: 200,
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.r),
                      color: Color(0xffDADAE0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            circle_image("",
                                radius: 12.r, backgroundClr: AppColors.white),
                            SizedBox(
                              width: 10.w,
                            ),
                            greyBoldText("Nick",
                                size: 13.sp, color: AppColors.black),
                            Spacer(),
                            greyBoldText("24/04/2024 | 10:15 PM",
                                color: AppColors.text, size: 13.sp),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        greyBoldText("Keyword",
                            color: AppColors.text.withOpacity(.3), size: 12.sp),
                        SizedBox(
                          height: 5.h,
                        ),
                        greyBoldText("Lorem Ipsum is simply dummy text",
                            color: AppColors.text, size: 13.sp),
                        SizedBox(
                          height: 5.h,
                        ),
                        greyBoldText("Message",
                            color: AppColors.text.withOpacity(.3), size: 12.sp),
                            SizedBox(
                          height: 5.h,
                        ),
                        greyBoldText(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                            color: AppColors.text,
                            size: 13.sp),
                        SizedBox(
                          height: 18.h,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: AppColors.primary,
                              size: 24.sp,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            greyBoldText("koratty, Thrissur, Kerala",
                                size: 13.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.text),
                            Spacer(),
                            CustomCircleIconWidget(
                              radius: 18.r,
                              iconSize: 18,
                              iconColor: AppColors.primary,
                              iconData: Icons.share,
                              backgroundClr: AppColors.primary.withOpacity(.2),
                              onCange: () {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
