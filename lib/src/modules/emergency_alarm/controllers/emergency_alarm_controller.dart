import 'package:get/get.dart';
import 'package:info91/src/models/profile.dart';
import 'package:info91/src/modules/recipients/recipients_add_page.dart';

class EmergencyAlarmController extends GetxController {
  final profiles = Profile.dummyList().take(3).toList().obs;

  static EmergencyAlarmController get() => Get.find<EmergencyAlarmController>();

  void onSendEmergencyPressed() {}

  void onAddRecipients() {
    Get.toNamed(RecipientsAddPage.routeName);
  }
}
