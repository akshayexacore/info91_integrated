import 'package:get/get.dart';
import 'package:info91/src/models/profile.dart';

class RecipientsAddController extends GetxController {
  final contacts = <String, List<Profile>>{}.obs;

  final selectedContacts = <Profile>[].obs;

  final selectedProfiles = Profile.dummyList().take(3).toList().obs;

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

  void onDonePressed() {}

  void onSelectedContact(Profile profile) {
    if (!selectedContacts.contains(profile)) {
      selectedContacts.add(profile);
    } else {
      selectedContacts.remove(profile);
    }
  }
}
