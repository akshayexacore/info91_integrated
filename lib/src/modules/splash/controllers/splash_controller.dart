

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/variables.dart';
import 'package:info91/src/modules/auth/login/controllers/auth_controller.dart';
import 'package:info91/src/resources/infromation_repository.dart';


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
      final Iterable<Contact> contacts = await FlutterContacts.getContacts( withProperties: true);
       List<String> phoneNumbers = [];
    for (var contact in contacts) {
      for (var phone in contact.phones) {
        phoneNumbers.add(phone.number);
      }
    }

      
      Variables.userContact = contacts.toList();
   Variables.userContactnum =    Variables.userContact
        .where((contact) => contact.phones.isNotEmpty) // Filter contacts with at least one phone number
        .expand((contact) => contact.phones.map((phone) => {
              'name': contact.displayName, // Get the contact's display name
              'number': phone.number, // Get the phone number
            }))
        .toList();
    } catch (e) {
      print('Error fetching contacts: $e');
    }
  }

}
