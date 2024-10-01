import 'package:get/get.dart';
import 'package:info91/src/models/profile.dart';
import 'package:info91/src/modules/chat/chat_page.dart';

class ContactSelectController extends GetxController {
  final recentChats = <String, List<Profile>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _getProfiles();
  }

  void _getProfiles() {
    recentChats({
      'A': Profile.dummyList(),
      'B': Profile.dummyList(),
      'P': Profile.dummyList(),
    });
  }

  void gotoChatPage(Profile profile) {
    Get.toNamed(ChatPage.routeName);
  }
}
