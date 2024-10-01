import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';
import 'package:pinput/pinput.dart';

import 'controllers/login_controller.dart';

class OtpPage extends StatelessWidget {
  OtpPage({Key? key}) : super(key: key);

  static const routeName = '/otp';

  final _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (val) async {
        _loginController.cancelTimer();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.splashBackground,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: Image.asset('assets/images/ic_enter_otp.png')),
                  const SizedBox(
                    height: AppSpacings.xMedium,
                  ),
                  const Text(
                    "Enter verification code",
                    style: AppTextStyles.appTitle,
                  ),
                  const SizedBox(
                    height: AppSpacings.xSmall,
                  ),
                  Text(
                      "Enter the otp received on your mobile number\n+${_loginController.country.value.phoneCode} ${_loginController.textControllerPhone.text.trim()}",
                      style: AppTextStyles.app14N,
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: AppSpacings.medium,
                  ),
                  Pinput(
                    defaultPinTheme: PinTheme(
                      width: 55,
                      height: 55,
                      textStyle: AppTextStyles.inputText,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.border, width: 1),
                          borderRadius: BorderRadius.circular(AppRadii.small),
                          color: AppColors.white),
                    ),
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    showCursor: true,
                    length: 4,
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsRetrieverApi,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    controller: _loginController.textControllerOtp,
                    onChanged: (pin) {
                      _loginController.isOtpValid(pin.length == 6);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return AppButton(
                        text: "Verify and Confirm",
                        busy: _loginController.busy.value,
                        onPressed: _loginController.verifyOtp);
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    if (_loginController.resendRemaining.value > 0) {
                      return Padding(
                        padding: const EdgeInsets.only(top: AppSpacings.medium),
                        child: Text(
                          'Resend Code in ${_loginController.resendRemaining.value} Sec',
                          style: AppTextStyles.appContent,
                        ),
                      );
                    }

                    return !_loginController.busy.value
                        ? TextButton(
                            onPressed: _loginController.resendRemaining.value == 0
                                ? () {
                                    _loginController.verifyPhone();
                                    _loginController.startTimer(
                                        _loginController.timerDuration2);
                                  }
                                : null,
                            child: Text.rich(TextSpan(
                                text: "Didn’t receive the OTP?",
                                style: AppTextStyles.app14N
                                    .copyWith(fontWeight: FontWeight.w600),
                                children: [
                                  TextSpan(
                                    text: " Resend OTP",
                                    style: AppTextStyles.app14N.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondary),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _loginController.verifyPhone();
                                      },
                                  )
                                ])),
                          )
                        : const SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          );
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
