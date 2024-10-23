import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/informationgroup/category_model.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/informtion_group_creation.dart/group_creation_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/validity_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_arrow_button.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custome_space_between_text.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/dropdown.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/new_input_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/custom/custom_divider.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';

class InformGroupCreationScreen extends StatelessWidget {
  InformGroupCreationScreen({super.key});
  final GroupCreationController _controller =
      Get.put(GroupCreationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBar(
          imageUrl: "",
          appBarName: "Create Group",
          actionWidget: [
            customTextButton("Submit", onTap: () {
              _controller.saveButtonPress();
            })
          ],
        ),
        Expanded(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: marginWidth),
            child: Form(
              key: _controller.formkey,
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

                  Obx((){
                    return CustomDropDownWidget<String>(
                      title: "Type",suffixIconData: _controller.typeController.value.isEmpty?Icons.arrow_drop_down:Icons.clear,
                      getItemTAble: (ak) => ak,
                      onChanged: (va) {
                        _controller.typeController.value = va ?? "";
                        // if(_controller.typeController.value=="business" && _controller.planList.isNotEmpty)
                        _controller.getPlanList();
                      },
                      itemList: ["business", "Non-business"],
                      selectedItem: "",
                    );}
                  ),

                  SizedBox(
                    height: 10.h,
                  ),
                  NewInputCard(
                    label: "Enter group name",
                    showValidator: true,
                    validatorMessage: "Please enter group name",
                    controller: _controller.groupNameController,
                    title: "Group Name",
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  NewInputCard(
                    controller: _controller.purposeController,
                    title: "Purpose",
                    showValidator: true,
                    validatorMessage: "Please enter purpose",
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
                  Obx(
                    () {
                      debugPrint(_controller.firstCategoryList.toString());
                      return CustomDropDownWidget<Category>(
                          title: "Category1",
                          getItemTAble: (ak) => ak.firstCategoryName,
                          onChanged: (va) {
                            _controller.categoryOneSelection(va);

                            print(
                                "clearing${_controller.selectedCategory2.value}");
                          },
                          itemList: _controller.firstCategoryList ?? [],
                          selectedItem:
                              Category(firstCategoryName: "ok", id: 1));
                    },
                  ),

                  // NewInputCard(
                  //   controller: _controller.category1Controller,
                  //   title: "Category1",
                  //   label: "Select category",
                  //    showValidator: true,
                  //   validatorMessage: "Please choose category1",
                  // ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Obx(
                    () {
                      debugPrint(_controller.secondCatList.toString());
                      return CustomDropSearcDownWidget<SecondCategory>(
                          title: "Category2",
                          isValidator:
                              _controller.selectedCategory2.value == null,
                          getItemLabel: (ak) => ak.secondCategoryName ?? "",
                          onChanged: (va) {
                            _controller.category2Selection(va);
                          },
                          itemList: _controller.secondCatList ?? [],
                          selectedItem:_controller.selectedCategory2.value);
                    },
                  ),
                  // NewInputCard(
                  //   controller: _controller.category2Controller,
                  //   title: "Category2",
                  //   label: "Select category",
                  //   showValidator: true,
                  //   validatorMessage: "Please choose category2",
                  // ),
                  SizedBox(
                    height: 15.h,
                  ),

                  Obx(
                    () {
                      debugPrint(_controller.secondCatList.toString());
                      return CustomDropSearcDownWidget<ThirdCategoryModel>(
                          title: "Category3",
                          getItemLabel: (ak) => ak.thirdCategoryName ?? "",
                          onChanged: (va) {
                            _controller.category3Selection(va);},
                          itemList: _controller.thirdCatList ?? [],
                          selectedItem: _controller.selectedCategory3.value);
                    },
                  ),
                  // NewInputCard(
                  //   controller: _controller.category3Controller,
                  //   title: "Category3",
                  //   label: "Select category",
                  //   showValidator: true,
                  //   validatorMessage: "Please choose category3",
                  // ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Obx(() {
                    return _controller.typeController.value == "business"
                        ? Column(
                            children: [
                              CustomArrowTextbutton(
                                toptitle: "Choose packages",
                                buttonName: "Validity palns",
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ValidityScreen(),
                                      ));
                                },
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Obx(() {
                                return _controller.planId != 0
                                    ? CustomSpcaeBetweenText(
                                        leftText: _controller
                                                .selectedPlanModel.planName ??
                                            "",
                                        rightText: ((_controller
                                                        .selectedPlanModel
                                                        .tax ??
                                                    0) +
                                                (_controller.selectedPlanModel
                                                        .amount ??
                                                    0))
                                            .toStringAsFixed(2),
                                      )
                                    : SizedBox();
                              }),
                            ],
                          )
                        : SizedBox();
                  }),
                ],
              ),
            ),
          ),
        ))
      ],
    ));
  }
}
