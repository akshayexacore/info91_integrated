import 'package:get/get.dart';
import 'package:info91/src/modules/emergency_alaram_update/pages/emergency_updated_main_screen.dart';
import 'package:info91/src/modules/emergency_alaram_update/pages/verify_number_screen.dart';


class HomeController extends GetxController {
  static HomeController get() => Get.find<HomeController>();

  void onEmergencyAlarmPressed() {
    Get.toNamed(EmergencyUpdatedMainScreen.routeName);
  }
}
