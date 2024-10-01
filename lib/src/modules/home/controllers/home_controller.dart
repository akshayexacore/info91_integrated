import 'package:get/get.dart';
import 'package:info91/src/modules/emergency_alarm/emergency_alarm_page.dart';

class HomeController extends GetxController {
  static HomeController get() => Get.find<HomeController>();

  void onEmergencyAlarmPressed() {
    Get.toNamed(EmergencyAlarmPage.routeName);
  }
}
