
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
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      Get.find<AuthController>().gotoLandingPage();
    });
    isBusy(false);
  }
  //  Future<void> _requestContactPermission() async {
  //   if (await Permission.contacts.request().isGranted) {
      
  //     fetchContacts();
  //   } else {
  //     print('Contact permission denied');
  //   }
  // }

  // Future<void> fetchContacts() async {
  //   try {
  //     final Iterable<Contact> contacts = await ContactsService.getContacts();
      
  //     Variables.userContact = contacts.toList();
  //   } catch (e) {
  //     print('Error fetching contacts: $e');
  //   }
  // }

}
