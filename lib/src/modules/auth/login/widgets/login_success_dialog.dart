import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/auth/login/controllers/auth_controller.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';

class LoginSuccessDialog extends StatelessWidget {
  const LoginSuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.medium),
        ),
        child: Container(
          width: AppSizes.alertDialog,
          padding: const EdgeInsets.all(AppPaddings.alertDialog),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.12,child: Image.asset('assets/images/ic_otp_success.png')),
              const SizedBox(height: AppSpacings.xMedium,),
              const Text("Success",style: AppTextStyles.appTitle,),
              const SizedBox(height: AppSpacings.xSmall,),
              const Text("Your account has been verified",style: AppTextStyles.app14N,textAlign: TextAlign.center),
              const SizedBox(height: AppSpacings.medium,),
                  AppButton(
                    text: "OK",
                    onPressed: Get.find<AuthController>().gotoLandingPage,
                    style: AppButtonStyles.alertDialogPositive,
                    height: AppSizes.dialogButtonHeight,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
