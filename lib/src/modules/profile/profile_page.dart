import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/profile/controllers/profile_controller.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';
import 'package:info91/src/widgets/tiny/app_input_text.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';


class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  static const routeName = '/profile';

  final _controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.splashBackground,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: AppSpacings.small,
                  ),
                  const Text("Profile",style: AppTextStyles.appTitle,),
                  const SizedBox(
                    height: AppSpacings.xxLarge,
                  ),
                  Obx((){
                    return Stack(
                      children: [
                        CircleAvatar(radius: 60,child: _controller.selectedFile.value.isURL || _controller.selectedFile.isEmpty ? AppNetworkImage(_controller.selectedFile.value,placeholder: Image.asset("assets/images/ic_user.png")) : ClipRRect(borderRadius: BorderRadius.circular(60),child: Image.file(File(_controller.selectedFile.value),fit: BoxFit.cover,height: 120,width: 120,))),
                        Positioned(bottom: 0,right: 0,child: GestureDetector(onTap: _controller.showUploadOptions,child: const CircleAvatar(radius: 17,backgroundColor: AppColors.primary,child: Icon(Icons.edit,color: AppColors.white,size: 20),)))
                      ],
                    );
                  }),
                  const SizedBox(
                    height: AppSpacings.medium,
                  ),
                  AppInputText(
                      shadow: false,
                      border: true,
                      hintText: "Full Name",
                      keyboardType: TextInputType.name,
                      controller: _controller.textControllerName,
                      ),
                  const SizedBox(
                    height: 15,
                  ),
                    Obx((){
                      debugPrint("bool value${_controller.errorMessage.value.isEmpty.toString()}");
                     return AppInputText(
                        shadow: false,
                        border: true,
                        maxLength: _controller.errorMessage.value.isEmpty?6:null,
                        hintText: "Pincode",
                        isError: _controller.isError.value,
                        onChanged:_controller.pinTextfieldOnchage,
                        onlyNumbers: true,
                        errormessage:_controller.errorMessage.value ,
                        
                        keyboardType: TextInputType.number,
                        controller: _controller.textControllerPincode,
                      
                        );}
                    ),
                   const SizedBox(
                    height: 15,
                  ),
                  AppInputText(
                      shadow: false,
                      border: true,
                      hintText: "About",
                      keyboardType: TextInputType.name,
                      controller: _controller.textControllerAbout,
                      ),
                  const SizedBox(
                    height: AppSpacings.xxxLarge,
                  ),
                  Obx(() {
                    return AppButton(
                        text: "DONE",
                        busy: _controller.busy.value,
                        onPressed: _controller.updateProfile);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
