import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/chat_screen/info_group_chat_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/profile_screen.dart';
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
    return CustomScaffold(
      children: [
        const CustomAppBar(
          imageUrl:
              "https://s3-alpha-sig.figma.com/img/1d0e/383d/b6e3946fdbb59adc0ab258d3c0726b43?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=hqY18ZgpQ4HigC3lhlKqEd2c-i1msfmir7yXKRJycSUV705Oqm2oC0oTZrTzsv3PDayakYS25bpREtmCWAB~DN~yUMsg3W9XJtk5QStTKAwd8m9Pcgt3l-QQ5qsSx1Bo5a6-7OpOQmFBtXM2a6Sf-JFfc20ZsfCFnBOcpHeCcyyNKaQpoLxo~3OBVnzcbs9Te0wjotXKCBkoiZVEHmV5sztkAv3HD9Ro4sh4rGtyzMvHGMUxN-dyqZiEJJVlVjPmj56lH~WMeqivTTJgAFsfvf1TyoNG97AcDnnQTuvIsB9sBNiek9hKtyCFzCQp4TOc63KOEkzNilLLQn-aEm4TwQ__",
          appBarName: "Lorem Ipsum",
        ),
        const ProfileTopImageSec(
          isProfile: false,
          backGroundImage:
              "https://s3-alpha-sig.figma.com/img/7eb1/5aa2/b39983facffc91323415afccde962741?Expires=1728864000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Ih2DM9CiJ6XpHCKoVfhYgmHeOEGdd3QlWBkiV0qIB70LqywdvITAlMwLHez0KqrXSVxhtW5Dvs4FxDiPu9KXqyVPLqlfW9rvlADuVkTJ9UqxW3G326kZTucPazfnfT1oM4e6fS~owGpmfwBk-PZ84un1RXjKXjjHvQ2MqmDPx7fW7nNEo6ujSNJLbwg8rahGoTGkxe0936nNb0-uJfmX5iivpbeIEdyaxi12gIFg8YrCIdTmVLGLH18n98IUXdb5JentY-3ZFZJwD2gTT3jvKElVbOQYNUZQkHZ9WTC~Lfoz~rCdwqIcGJKdy63CQ2KHqJNP8mzwyIc8MZ4w-K6uEw__",
          profileImage:
              "https://s3-alpha-sig.figma.com/img/35e8/9d9d/e5b9d1d23149590ef05ef35d5019c1af?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=qqj9NDxLQ62C0Qg6~MQQSZ5GaRk~u1~DGuRCFkGIyzxIl9ro~QiH7sKpqES3Vfh2Vz5rHPZZq-Xrq9vaz840HBavPUgmr34V3lTXCeUFze9Sg1lXyvkmXSqqyfDnQiJegGLhcnDZP30ip7Wo77D-YFZhJlDKg58UjFcyr80mbwpErKO0YaT-ndZOroyuXHDiH6oBJwj-odwRH55Vlaaj5TTraPFHMchFJhJ1dv6atYIIwFyukiF2HplWCzSrtwLJZtWY9DxPb-WNP37NSQTFOROBZ-lwJv7svxE7zMkQWeD5lLjhxTWUGCMMqCwGnHVouLxxO8E0Y5CD~z1db~6aeQ__",
        ),
        Expanded(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: marginWidth),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Row(
                children: [
                  greyBoldText("Group Name",
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                      size: 16.sp),
                  Spacer(),
                  clickebleIcon("assets/images/youtube.png", () {}),
                  SizedBox(
                    width: 20.w,
                  ),
                  clickebleIcon("assets/images/world.png", () {}),
                  SizedBox(
                    width: 20.w,
                  ),
                  clickebleIcon("assets/images/map.png", () {}),
                ],
              ),
              SizedBox(
                height: 8.h,
              ),
              greyContentText(
                "1k members",
              ),
              SizedBox(
                height: 15.h,
              ),
              ExpandableTextWidget(
                text:
                    "Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
              ),
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
              BannersImageView(imageList: [
                "https://s3-alpha-sig.figma.com/img/674c/ebe1/163a0f5534eb6b60ce27af5086f6ae3a?Expires=1728864000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=EeDFDDWWb88~c8gy8o2fUQu0vMU0Jx8ip5IfpaTzSx8Z6GDpwLEBAAhuLvNF4Nvq6pyDN5aGBTc035ZQ3kH-8oo01v4Ow6JlUD3X18KrHGEIXeTBPcredtQYLS8fAU6KtLQH2miIDbZJxvebFu9u61kDTY06egJrgIsR9qxIQ7heSzING~026zIgl3bQiK9XXR44a3oyc5rF8-ypl17kKT9fSMJXl3BJoUlrhyEZaXjP3TokRJuC03kci8238MpFMnHKkQ7kILvGaXz-vHdVOt~ElSz7vOMvzKlv6AX3tE3vp4Q3GcFXNfQr5rFo2nzQeZLaOpN5ioSRUkVBZWQ37w__",
                "https://s3-alpha-sig.figma.com/img/674c/ebe1/163a0f5534eb6b60ce27af5086f6ae3a?Expires=1728864000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=EeDFDDWWb88~c8gy8o2fUQu0vMU0Jx8ip5IfpaTzSx8Z6GDpwLEBAAhuLvNF4Nvq6pyDN5aGBTc035ZQ3kH-8oo01v4Ow6JlUD3X18KrHGEIXeTBPcredtQYLS8fAU6KtLQH2miIDbZJxvebFu9u61kDTY06egJrgIsR9qxIQ7heSzING~026zIgl3bQiK9XXR44a3oyc5rF8-ypl17kKT9fSMJXl3BJoUlrhyEZaXjP3TokRJuC03kci8238MpFMnHKkQ7kILvGaXz-vHdVOt~ElSz7vOMvzKlv6AX3tE3vp4Q3GcFXNfQr5rFo2nzQeZLaOpN5ioSRUkVBZWQ37w__"
              ]) // Spacer(),
            ],
          ),
        )),
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
                      backgroundColor: WidgetStatePropertyAll(AppColors.white)),
                  textStyle:
                      AppTextStyles.appButton.copyWith(color: AppColors.black),
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
                  textStyle:
                      AppTextStyles.appButton.copyWith(color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
