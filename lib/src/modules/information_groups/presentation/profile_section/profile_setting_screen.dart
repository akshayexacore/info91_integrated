import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/banners_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/profile_section/profile_screen.dart';

import 'package:info91/src/modules/information_groups/presentation/widgets/custom_arrow_button.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_scaffold.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/new_input_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';

import '../widgets/profile_top_image_sec.dart';

class ProfileSettingScreen extends StatelessWidget {
  ProfileSettingScreen({super.key});
  var constGap = SizedBox(
    height: 15.h,
  );
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      children: [
        CustomAppBar(
          imageUrl: "",
          actionWidget: [customTextButton("Save", onTap: () {})],
          appBarName: "Group Settings",
        ),
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileTopImageSec(
                backGroundImage:
                    "https://s3-alpha-sig.figma.com/img/674c/ebe1/163a0f5534eb6b60ce27af5086f6ae3a?Expires=1728864000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=EeDFDDWWb88~c8gy8o2fUQu0vMU0Jx8ip5IfpaTzSx8Z6GDpwLEBAAhuLvNF4Nvq6pyDN5aGBTc035ZQ3kH-8oo01v4Ow6JlUD3X18KrHGEIXeTBPcredtQYLS8fAU6KtLQH2miIDbZJxvebFu9u61kDTY06egJrgIsR9qxIQ7heSzING~026zIgl3bQiK9XXR44a3oyc5rF8-ypl17kKT9fSMJXl3BJoUlrhyEZaXjP3TokRJuC03kci8238MpFMnHKkQ7kILvGaXz-vHdVOt~ElSz7vOMvzKlv6AX3tE3vp4Q3GcFXNfQr5rFo2nzQeZLaOpN5ioSRUkVBZWQ37w__",
                profileImage:
                    "https://s3-alpha-sig.figma.com/img/674c/ebe1/163a0f5534eb6b60ce27af5086f6ae3a?Expires=1728864000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=EeDFDDWWb88~c8gy8o2fUQu0vMU0Jx8ip5IfpaTzSx8Z6GDpwLEBAAhuLvNF4Nvq6pyDN5aGBTc035ZQ3kH-8oo01v4Ow6JlUD3X18KrHGEIXeTBPcredtQYLS8fAU6KtLQH2miIDbZJxvebFu9u61kDTY06egJrgIsR9qxIQ7heSzING~026zIgl3bQiK9XXR44a3oyc5rF8-ypl17kKT9fSMJXl3BJoUlrhyEZaXjP3TokRJuC03kci8238MpFMnHKkQ7kILvGaXz-vHdVOt~ElSz7vOMvzKlv6AX3tE3vp4Q3GcFXNfQr5rFo2nzQeZLaOpN5ioSRUkVBZWQ37w__",
                isAdmin: true,
              ),
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: marginWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    greyBoldText("Group Name",
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                        size: 16.sp),
                    constGap,
                    NewInputCard(
                      controller: TextEditingController(),
                      title: "About us",
                      height: 80,
                      maxLines: 3,
                    ),
                    constGap,
                    NewInputCard(
                      controller: TextEditingController(),
                      title: "You can add up to 3 keywords.",
                      label: "#tags #tags #tags",
                      colors: AppColors.text.withOpacity(.75),
                      fontsize: 12.sp,
                    ),
                    constGap,
                    greyBoldText("Contact Details",
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                        size: 16.sp),
                    constGap,
                    Row(
                      children: [
                        Expanded(
                          child: NewInputCard(
                            controller: TextEditingController(),
                            title: "Mobile Number",
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          child: NewInputCard(
                            controller: TextEditingController(),
                            title: "Alternative Number",
                          ),
                        )
                      ],
                    ),
                    constGap,
                    Row(
                      children: [
                        Expanded(
                          child: NewInputCard(
                            controller: TextEditingController(),
                            title: "Whatsapp Number",
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          child: Container(),
                        )
                      ],
                    ),
                    constGap,
                    greyBoldText("Timings and Holidays",
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                        size: 16.sp),
                    constGap,
                    Row(
                      children: [
                        Expanded(
                          child: NewInputCard(
                            controller: TextEditingController(),
                            title: "Contact Time",
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          child: NewInputCard(
                            controller: TextEditingController(),
                            title: "Holidays",
                          ),
                        )
                      ],
                    ),
                    constGap,
                    greyBoldText("Banners",
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                        size: 16.sp),
                    constGap,
                    BannersImageView(
                      imageList: [],
                    ),
                    CustomArrowTextbutton(
                        buttonName: "Add Banners",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BannersScreen(),
                              ));
                        }),
                    constGap,
                    greyBoldText("Others",
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                        size: 16.sp),
                    constGap,
                    Row(
                      children: [
                        Expanded(
                          child: NewInputCard(
                            controller: TextEditingController(),
                            title: "Website link",
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(
                          child: NewInputCard(
                            controller: TextEditingController(),
                            title: "Website link",
                          ),
                        )
                      ],
                    ),
                    constGap,
                    Row(
                      children: [
                        Expanded(
                          child: NewInputCard(
                            controller: TextEditingController(),
                            title: "Google map link",
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ))
      ],
    );
  }
}
