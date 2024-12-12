import 'dart:async';
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/configs/firebase.dart';
import 'package:info91/src/models/user.dart';
import 'package:info91/src/modules/auth/login/controllers/auth_controller.dart';
import 'package:info91/src/modules/auth/login/login_page.dart';
import 'package:info91/src/modules/auth/login/otp_page.dart';
import 'package:info91/src/modules/auth/login/widgets/login_success_dialog.dart';
import 'package:info91/src/resources/auth_repository.dart';
import 'package:info91/src/resources/shared_preferences_data_provider.dart';
import 'package:info91/src/resources/user_profile_repository.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class LoginController extends GetxController {
  late var busy = false.obs;
  late var isPhoneValid = false.obs;
  late var isOtpValid = false.obs;
  late final resendRemaining = 0.obs;

  late Timer _timer;
  final int timerDuration2 = 180;

  final int timerDuration1 = 60;

  late final textControllerPhone = TextEditingController();
  late final textControllerOtp = TextEditingController();

  late final _authRepository = AuthRepository();
  late final _userProfileRepository = UserProfileRepository();
 late final _preferences = SharedPreferencesDataProvider();
  late final _authController = Get.find<AuthController>();

  var country = Country.parse("IN").obs;

  var phone = const PhoneNumber(isoCode: IsoCode.IN, nsn: "").obs;

  @override
  void onInit() {
    busy = _authController.busy;
    textControllerPhone.addListener(() {
      validatePhone();
    });
    super.onInit();
  }

  Future<void> requestSmsPermission() async {
    var status = await Permission.sms.status;
    if (!status.isGranted) {
      await Permission.sms.request();
    }
  }  
  
  Future<String> _initDeviceId() async {
    String? deviceId;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        var androidInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.id; // Use `androidId` for Android
      } else if (Platform.isIOS) {
        var iosInfo = await deviceInfoPlugin.iosInfo;
        deviceId = iosInfo.identifierForVendor; // Use `identifierForVendor` for iOS
      } else {
        deviceId = 'Unsupported platform';
      }
    } catch (e) {
      deviceId = 'Failed to get device ID';
    }

   return deviceId??"";
  }

  void verifyPhone() async {
    busy(true);
    try {
      await requestSmsPermission();
      if (phone.value.isValid()) {
        final deviceId=await _initDeviceId();
        final response = await _authRepository.sendOtp(
            phone.value.nsn, phone.value.countryCode,deviceId);

        if (response.isSuccess) {
          busy(false);
          if (response.exist == true) {
            final token=await _preferences.getFcmToken();
               print("the token is here1${FirebaseApi.fcmToken}");
            await _authRepository
                .saveAccessToken('${response.tokenType} ${response.token}');
            await _authRepository.saveRefreshToken(response.token ?? "");
            debugPrint("response.result${response}");

            await _userProfileRepository
                .saveUser(User.fromJson(response.result));
            await _authRepository.upDateFcmToken(
               fcmken: FirebaseApi.fcmToken
               ??"");
            _authController.gotoLandingPage();
            // showSuccessDialog();
          } else {
            gotoOtpPage();
          }
        } else {
          busy(false);
          AppDialog.showSnackBar('Failed to send OTP',
              'OTP sending failed, please check the number.');
        }
      } else {
        busy(false);
        AppDialog.showSnackBar(
            'Invalid phone number', 'Please check the phone number.');
      }
    } catch (e) {
      busy(false);
      debugPrint("the error is here${e.toString()}");
      AppDialog.showSnackBar('Login Failed', 'Something went wrong.');
    } finally {}
  }

  void gotoLoginPage() {
    Get.offAllNamed(LoginPage.routeName);
  }

  void gotoLandingPage() async {
    _authController.gotoLandingPage();
  }

  void gotoTermsCondition() {}

  void gotoCountryPicker() {
    showCountryPicker(
      context: Get.context!,
      showPhoneCode: true,
      favorite: ["IN"],
      countryListTheme: CountryListThemeData(
          borderRadius: BorderRadius.circular(15),
          bottomSheetHeight: MediaQuery.of(Get.context!).size.height * 0.6,
          textStyle: AppTextStyles.app14N,
          inputDecoration: InputDecoration(
              labelText: "Search",
              hintText: "Search",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xFF8C98A8).withOpacity(0.2),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 3))),
      onSelect: (Country c) {
        country(c);
        validatePhone();
      },
    );
  }

  void validatePhone() {
    try {
      final phoneCheck = PhoneNumber.parse(
          '+${country.value.phoneCode} ${textControllerPhone.text.trim()}');
      isPhoneValid(phoneCheck.isValid(type: PhoneNumberType.mobile));
      phone(phoneCheck);
    } catch (_) {
      isPhoneValid(false);
    }
  }

  void gotoOtpPage() {
    Get.toNamed(OtpPage.routeName);
    startTimer(timerDuration1);
  }

  void startTimer(int duration) {
    resendRemaining(duration);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendRemaining.value > 0) {
        resendRemaining.value--;
      } else {
        _timer.cancel();
      }
    });
  }

  void cancelTimer() {
    _timer.cancel();
  }

  void verifyOtp() async {
    busy(true);
    try {
      if (textControllerOtp.text.isNotEmpty &&
          textControllerOtp.text.length == 4) {
        final response = await _authRepository.verifyOtp(
            phone.value, textControllerOtp.text);

        if (response.success) 
        {
          final token=await _preferences.getFcmToken();
          print("the token is here${FirebaseApi.fcmToken}");
          await _authRepository.upDateFcmToken(
               fcmken: FirebaseApi.fcmToken??"");
          await _authRepository
          
              .saveAccessToken('${response.tokenType} ${response.token}');
          await _authRepository.saveRefreshToken(response.refreshToken);
          await _userProfileRepository.saveUser(response.user!);
          showSuccessDialog();
        } else {
          AppDialog.showSnackBar('Otp Verification Failed', response.message);
          busy(false);
        }
      } else {
        Get.closeAllSnackbars();
        AppDialog.showSnackBar('Invalid OTP', 'Please enter a valid OTP');
        busy(false);
      }
    } catch (e) {
      print("the error is here$e");
      busy(false);
      AppDialog.showSnackBar('Otp Verification Failed', 'Something went wrong');
    } finally {}
  }

  void reSendOtp() async {
    busy(true);
    try {
      await requestSmsPermission();
      if (phone.value.isValid()) {
        final response = await _authRepository.reSendOtp(
            phone.value.nsn, phone.value.countryCode);

        if (response.isSuccess) {
          busy(false);

          await _authRepository
              .saveAccessToken('${response.tokenType} ${response.token}');
          await _authRepository.saveRefreshToken(response.token ?? "");
          debugPrint("response.result${response.result["id"]}");

          await _userProfileRepository.saveUser(User.fromJson(response.result));

          // showSuccessDialog();
        } else {
          busy(false);
          AppDialog.showSnackBar('Failed to send OTP',
              'OTP sending failed, please check the number.');
        }
      } else {
        busy(false);
        AppDialog.showSnackBar(
            'Invalid phone number', 'Please check the phone number.');
      }
    } catch (e) {
      busy(false);
      debugPrint(e.toString());
      AppDialog.showSnackBar('Login Failed', 'Something went wrong.');
    } finally {}
  }
}

void showSuccessDialog() {
  Get.dialog(const LoginSuccessDialog(), barrierDismissible: false);
}
  