import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_popupmenu.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/app_message_profile_tile.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';

class AlarmHistoryScreen extends StatelessWidget {
  static const route = "/alarm_historyscreen";
  const AlarmHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomAppBar(
            appBarName: "Emergency Alarm",
            isTextield: true,
            actionWidget: [
              CustomPopupmenu(onSelected: (value) {}, itemList: [
                popupMenuModel(name: "Create Alarm Group", value: 1)
              ])
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: marginWidth, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  greyBoldText("Alarm Ringing"),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xff2622621A).withOpacity(.10),
                        borderRadius: BorderRadius.circular(12.r)),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) => AppAlarmProfileTile(
                        imageUrl:
                            "https://s3-alpha-sig.figma.com/img/3ccd/3c80/b824c0f0656c4b3dbf063147cda4ea28?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ZCOoOYVMSKpbf~yYMEebuCicFLN075nl1bTxyqgeHZ1Km-64Uo0ZYt4DnoVEuiTbXPqU49daYo7LneO9cQVX63WgR2cLd4lfroT8DHHcQPpws6X~uErHJ6RZvcJ6vMPe1MIDdXI~DktSIaLqWwYmWmSioiFj~aqA4ZOefkXv~Byy~1ywgJw9L94Dj-783hqFaxMiMHMaZ4uDec75oT6nufhtKnhDN4afQi4fFPwEsiNsutza1s9cyyL8i1OFhvuVf0-aZK7gAW4SfPEfAFa59-Fy9YboBjLBt8tqdXxoqRpIoJizUyNzZrwai2KUhCoCqAW1mntvG~wT5F2xZl-uRg__",
                        title: "Office Group",
                        subTitle: "Office Group",
                        onButtonPressed: () {},
                        isButton: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  greyBoldText("History"),
                  SizedBox(
                    height: 20.h,
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) => const AppAlarmProfileTile(
                      imageUrl:
                          "https://s3-alpha-sig.figma.com/img/3ccd/3c80/b824c0f0656c4b3dbf063147cda4ea28?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ZCOoOYVMSKpbf~yYMEebuCicFLN075nl1bTxyqgeHZ1Km-64Uo0ZYt4DnoVEuiTbXPqU49daYo7LneO9cQVX63WgR2cLd4lfroT8DHHcQPpws6X~uErHJ6RZvcJ6vMPe1MIDdXI~DktSIaLqWwYmWmSioiFj~aqA4ZOefkXv~Byy~1ywgJw9L94Dj-783hqFaxMiMHMaZ4uDec75oT6nufhtKnhDN4afQi4fFPwEsiNsutza1s9cyyL8i1OFhvuVf0-aZK7gAW4SfPEfAFa59-Fy9YboBjLBt8tqdXxoqRpIoJizUyNzZrwai2KUhCoCqAW1mntvG~wT5F2xZl-uRg__",
                      title: "Office Group",
                      subTitle: "Office Group",
                      leading: "24/04/2024 | 10:15 PM",
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
