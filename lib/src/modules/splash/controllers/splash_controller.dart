
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/variables.dart';
import 'package:info91/src/modules/auth/login/controllers/auth_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashController extends GetxController {
  var isBusy = false.obs;

  @override
  void onInit() {
    gotoHomePage();
    super.onInit();
  }

  void gotoHomePage() async {
    isBusy(true);
    _requestContactPermission();
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      Get.find<AuthController>().gotoLandingPage();
    });
    isBusy(false);
  }
   Future<void> _requestContactPermission() async {
  final permissionGranted = await FlutterContacts.requestPermission(readonly: true,);
  if (permissionGranted) {
    print("Permission granted");
    await fetchContacts();
  } else {
    print('Contact permission denied');
    // Optionally show a dialog to inform the user
  }
}
  Future<void> fetchContacts() async {
    try {
      final Iterable<Contact> contacts = await FlutterContacts.getContacts( withThumbnail: true,   // Fetch thumbnails
      withPhoto: true, withProperties: true);
      
      Variables.userContact = contacts.toList();
    } catch (e) {
      print('Error fetching contacts: $e');
    }
  }

}
