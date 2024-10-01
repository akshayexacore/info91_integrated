import 'package:get/get.dart';
import 'package:info91/src/models/group.dart';
import 'package:info91/src/modules/chat/chat_page.dart';

class GroupsController extends GetxController {
  final recentChats = <Group>[].obs;

  @override
  void onInit() {
    super.onInit();
    _getGroups();
  }

  void _getGroups() {
    recentChats(Group.dummyList());
  }

  void gotoChatPage(Group profile) {
    Get.toNamed(ChatPage.routeName);
  }
}
