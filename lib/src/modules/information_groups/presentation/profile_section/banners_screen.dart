import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/profile_section/controller/banner_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/new_input_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';

class BannersScreen extends StatelessWidget {
  static const routeName = "/banner";
  BannersScreen({super.key});
  final _controller = Get.find<BannerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            imageUrl: "",
            imageOntap: () {},
            appBarName: "Banners",
            actionWidget: [
              if (_controller.isEdit.value)
                customTextButton("Delete", onTap: () {
                  _controller.showDeleteConfirmationDialog();
                })
            ],
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: marginWidth),
            child: Form(
              key: _controller.formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  greyContentText(
                      "You can add up to 10 photos with your current plan, and they will be automatically removed after 30 days."),
                  SizedBox(
                    height: 15.h,
                  ),
                  Obx(() {
                    debugPrint(
                        "_controller.imagePath.value${_controller.checkImageExist()}");
                    return Stack(
                      children: [
                        SizedBox(
                          height: 180.h,
                          width: double.infinity,
                          child: _controller.checkImageExist() == false
                              ? Center(
                                  child: IconButton(
                                    onPressed: () {
                                      _controller.pickImage();
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.black54,
                                      size: 30,
                                    ),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.r)),
                                  child: _controller.imagePath.value.isNotEmpty
                                      ? Image.network(
                                          fit: BoxFit.cover,
                                          _controller.imagePath.value)
                                      : Image.file(
                                          File(_controller.filePath.value),
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 150,
                                        ),
                                ),
                        ),
                        if (_controller.checkImageExist())
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                _controller.clearImage();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                    radius: 18.r,
                                    backgroundColor: AppColors.primary,
                                    child: const Icon(
                                      Icons.delete,
                                      color: AppColors.white,
                                    )),
                              ),
                            ),
                          )
                      ],
                    );
                  }),
                  SizedBox(
                    height: 15.h,
                  ),
                  NewInputCard(
                    controller: _controller.titleController,
                    title: "Title",
                    showValidator: true,
                    // isBorder: false,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  NewInputCard(
                    controller: _controller.descriptionController,
                    title: "Description",
                    maxLines: 3,
                    height: 90,
                    showValidator: true,
                    // isBorder: false,
                  ),
                  const Spacer(),
                  Obx(() {
                    return AppButton(
                      text: _controller.isEdit.value ? "Update" : "Save",
                      busy: false,
                      // icon: Icons.camera_alt,
                      onPressed: () {
                        _controller.isEdit.value
                            ? null
                            : _controller.createBanner();
                      },
                      style: AppButtonStyles.appButton.copyWith(
                          backgroundColor:
                              const WidgetStatePropertyAll(AppColors.white)),
                      textStyle: AppTextStyles.appButton
                          .copyWith(color: AppColors.black),
                    );
                  }),
                  SizedBox(
                    height: 15.h,
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
