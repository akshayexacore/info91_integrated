import 'package:get/get.dart';
import 'package:info91/src/modules/auth/login/login_page.dart';
import 'package:info91/src/modules/auth/login/welcome_page.dart';
import 'package:info91/src/modules/landing/landing_page.dart';
import 'package:info91/src/modules/profile/profile_page.dart';
import 'package:info91/src/resources/auth_repository.dart';
import 'package:info91/src/resources/user_profile_repository.dart';
import 'package:info91/src/utils/app_exception.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';

class AuthController extends GetxController {
  late final busy = false.obs;

  late final _authRepository = AuthRepository();
  late final _userProfileRepository = UserProfileRepository();

  void gotoLandingPage() async {
    try {
      busy(true);
      String token = await _authRepository.getAccessToken();
      if (token.isNotEmpty) {
        _gotoLandingPage();
      } else {
        gotoLoginPage();
      }
      busy(false);
    } catch (_) {
      gotoLoginPage();
    }
  }

  void _gotoLandingPage() async {
    try {
      // check if preference saved
      final response = await _userProfileRepository.getUser();
      if (response.success) {
        if (response.user != null && response.user!.name.isEmpty) {
          Get.offAllNamed(ProfilePage.routeName);
        } else {
          Get.offAllNamed(LandingPage.routeName);
        }
      } else if (response.statusCode == 401 || response.statusCode == 402) {
        gotoLoginPage();
      }
    } on FetchDataException catch (_) {
      showRetry();
    } catch (_) {
      if (_ is UnauthorisedException) {
        gotoLoginPage();
      } else {
        AppDialog.showToast(_.toString());
      }
    }
  }

  void showRetry() {
    AppDialog.showDialog(
        title: "No Internet connection",
        secondaryText: "Retry",
        onSecondaryPressed: () {
          _gotoLandingPage();
          Get.back();
        },
        content: "Please check your connection and try again.");
  }

  void gotoLoginPage() async {
    Get.offAllNamed(WelcomePage.routeName);
  }


  void logout() {
    _authRepository.logoutUser();
    Get.offAllNamed(LoginPage.routeName);
  }
}
