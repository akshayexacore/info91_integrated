import 'package:get/get.dart';
import 'package:info91/src/models/profile.dart';
import 'package:info91/src/modules/archived_chat/archived_chats_page.dart';
import 'package:info91/src/modules/chat/chat_page.dart';
import 'package:info91/src/modules/landing/controllers/landing_controller.dart';
import 'package:info91/src/modules/profile/controllers/profile_controller.dart';

class ChatsController extends GetxController {
  final recentChats = <Profile>[].obs;

  final archivedChats = <Profile>[].obs;

  final selectedChatIndexes = <int>[].obs;

  final selectedArchiveChatIndexes = <int>[].obs;

  final enableChatSelection = LandingController.get().enableChatSelection;

  final selectedProfileCount = LandingController.get().selectedProfileCount;

  static ChatsController get() => Get.find<ChatsController>();

  @override
  void onInit() {
    super.onInit();
    _getProfiles();
    enableChatSelection.listen((value) {
      if (!value) {
        onClearSelected();
      }
    });
    selectedChatIndexes.listen((value) {
      selectedProfileCount(selectedChatIndexes.length);
    });
  }

  void logout() {
    Get.find<ProfileController>().logout();
  }

  void _getProfiles() {
    recentChats(Profile.dummyList().take(5).toList());
  }

  void gotoChatPage(Profile profile) {
    Get.toNamed(ChatPage.routeName);
  }

  void onProfileLongPressed(int index) {
    if (selectedChatIndexes.isEmpty) {
      selectedChatIndexes.add(recentChats[index].id);
      enableChatSelection(true);
    }
  }

  void onArchiveProfileLongPressed(int index) {
    if (selectedArchiveChatIndexes.isEmpty) {
      selectedArchiveChatIndexes.add(archivedChats[index].id);
    }
  }

  void onClearSelected() {
    selectedChatIndexes.clear();
    LandingController.get().onChatSelectionSelected(false);
  }

  void onProfilePressed(int index) {
    if (!selectedChatIndexes.contains(recentChats[index].id)) {
      selectedChatIndexes.add(recentChats[index].id);
    } else {
      selectedChatIndexes.remove(recentChats[index].id);
      if (selectedChatIndexes.isEmpty) {
        onClearSelected();
      }
    }
  }

  void onArchiveProfilePressed(int index) {
    if (!selectedArchiveChatIndexes.contains(archivedChats[index].id)) {
      selectedArchiveChatIndexes.add(archivedChats[index].id);
    } else {
      selectedArchiveChatIndexes.remove(archivedChats[index].id);
    }
  }

  void onArchiveChat() {
    for (int id in selectedChatIndexes) {
      final selected = recentChats.firstWhere((element) => element.id == id);
      archivedChats.add(selected);
      recentChats.remove(selected);
    }
    onClearSelected();
  }

  void gotoArchivedChats() {
    Get.toNamed(ArchivedChatsPage.routeName);
  }

  void onRestoreArchivedChats() {
    for (int id in selectedArchiveChatIndexes) {
      final selected = archivedChats.firstWhere((element) => element.id == id);
      recentChats.add(selected);
      archivedChats.remove(selected);
    }
    selectedArchiveChatIndexes.clear();
  }
}
