import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/validity_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_arrow_button.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/new_input_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/custom/custom_divider.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';

class InformGroupCreationScreen extends StatelessWidget {
  const InformGroupCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            imageUrl: "",
            appBarName: "Create Group",
            actionWidget: [customTextButton("Submit", onTap: () {})],
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: marginWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  greyContentText(
                      "Fill out the  form below and our customer  support will connect you soon"),
                  SizedBox(
                    height: 15.h,
                  ),
                  NewInputCard(
                    controller: TextEditingController(),
                    title: "Type",
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  NewInputCard(
                    label: "Enter group name",
                    controller: TextEditingController(),
                    title: "Group Name",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  NewInputCard(
                    controller: TextEditingController(),
                    title: "Purpose",
                    height: 90,
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  customDivider(padding: EdgeInsets.zero),
                  SizedBox(
                    height: 15.h,
                  ),
                  greyContentText("Please select a category and a subcategory"),
                  SizedBox(
                    height: 15.h,
                  ),
                  NewInputCard(
                    controller: TextEditingController(),
                    title: "Category1",
                    label: "Select category",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  NewInputCard(
                    controller: TextEditingController(),
                    title: "Category2",
                    label: "Select category",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  NewInputCard(
                    controller: TextEditingController(),
                    title: "Category3",
                    label: "Select category",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomArrowTextbutton(
                    toptitle: "Choose packages",
                    buttonName: "Validity palns",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ValidityScreen(),
                          ));
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    ));
  }
}
