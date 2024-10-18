import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/informtion_group_creation.dart/group_creation_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/validity_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_arrow_button.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/new_input_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/custom/custom_divider.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';

class InformGroupCreationScreen extends StatelessWidget {
   InformGroupCreationScreen({super.key});
final GroupCreationController _controller=GroupCreationController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
                    CustomDropDownWidget<String>(title:"Type" ,getItemTAble:( ak)=>ak ,onChanged: (va){},itemList: ["Normal"],selectedItem: "sss",),
                    // NewInputCard(
                    //   controller: TextEditingController(),
                    //   title: "Type",
                    // ),
                    SizedBox(
                      height: 10.h,
                    ),
                    NewInputCard(
                      label: "Enter group name",
                      controller: _controller.groupNameController,
                      title: "Group Name",
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    NewInputCard(
                      controller: _controller.purposeController,
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
                      controller: _controller.category1Controller,
                      title: "Category1",
                      label: "Select category",
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    NewInputCard(
                      controller: _controller.category2Controller,
                      title: "Category2",
                      label: "Select category",
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    NewInputCard(
                      controller:  _controller.category3Controller,
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
        ));
  }
}
