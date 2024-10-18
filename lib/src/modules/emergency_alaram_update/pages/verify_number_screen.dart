import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/emergency_alaram_update/pages/emergency_updated_main_screen.dart';
import 'package:info91/src/modules/emergency_alaram_update/pages/emergeny_main_page.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/resources/user_profile_repository.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';
import 'package:pinput/pinput.dart';

class VerifyNumberAlarmScreen extends StatelessWidget {
  VerifyNumberAlarmScreen({super.key});
  static const routeName = '/numberalarmConfirmation';
  final textControllerOtp = TextEditingController();
  late final _userProfileRepository = UserProfileRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(appBarName: "Verify Number"),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: marginWidth),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                greyBoldText(
                  "For security, enter the last 4 digits of your registered mobile number to access the emergency alarm screen.",
                  size: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.text.withOpacity(.7),
                  height: 1.7.h,wordSpacing: 4.w
                ),
                SizedBox(
                  height: 30.h,
                ),
                Pinput(
                  separatorBuilder: (index) => Container(
                    height: 1.h,
                    width: 6.w,
                    color: AppColors.text,
                  ),
                  defaultPinTheme: PinTheme(
                    width: 55,
                    height: 55,
                    textStyle: AppTextStyles.inputText,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border, width: 1),
                        borderRadius: BorderRadius.circular(AppRadii.small),
                        color: AppColors.offWhite),
                  ),
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  length: 4,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsRetrieverApi,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  controller: textControllerOtp,
                  onChanged: (pin) {
                    // _loginController.isOtpValid(pin.length == 6);
                  },
                ),
                Spacer(),
                AppButton(
                  text: "Continue",
                  onPressed: () async{
                
                    if(textControllerOtp.text.trim().isEmpty || textControllerOtp.text.trim().length<4){
                    AppDialog.showSnackBar('Invalid ', 'Please enter 4 digits of your registerd number');
  
                    }else {
                       var response=await   _userProfileRepository.getUser();
                       if(response.user?.phoneNumber!=null){
                        var  checkingVal=response.user!.phoneNumber.substring(response.user!.phoneNumber.length-4);
                        debugPrint(checkingVal);
                        if(checkingVal==textControllerOtp.text.trim()){
                          Get.toNamed(EmergencyUpdatedMainScreen.routeName);

                        }
                        else{
                           AppDialog.showSnackBar('Invalid 4 digits ', 'Invalid 4 digits');

                        }



                       }

                    }




                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
