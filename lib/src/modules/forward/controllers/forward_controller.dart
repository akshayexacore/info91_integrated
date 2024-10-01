import 'package:get/get.dart';
import 'package:info91/src/models/profile.dart';

class ForwardController extends GetxController {
  final contacts = <String, List<Profile>>{}.obs;

  get contactsLength => contacts.values
      .fold(0, (previousValue, element) => previousValue + element.length);

  final selectedContacts = <Profile>[].obs;

  @override
  void onInit() {
    super.onInit();
    _getProfiles();
  }

  void _getProfiles() {
    contacts({
      'A': Profile.dummyList(),
      'B': Profile.dummyList(),
      'P': Profile.dummyList(),
    });
  }

  void gotoChatPage(Profile profile) {}

  void onSelectedContact(Profile profile) {
    if (!selectedContacts.contains(profile)) {
      selectedContacts.add(profile);
    } else {
      selectedContacts.remove(profile);
    }
  }

  void onSendPressed() {
    Get.back(result: true,);
  }
}
