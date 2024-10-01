import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/modules/contact_select/contact_select_page.dart';
import 'package:info91/src/modules/emergency_alarm/emergency_alarm_ring.dart';
import 'package:info91/src/modules/home/controllers/chats_controller.dart';
import 'package:info91/src/modules/settings/settings_page.dart';
import 'package:info91/src/modules/starred_chats/starred_chats_page.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';

class LandingController extends GetxController {
  final currentIndex = 0.obs;

  final PageController tabController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  final enableChatSelection = false.obs;

  final selectedProfileCount = 0.obs;

  static LandingController get() => Get.find<LandingController>();

  bool get enabledFab => (currentIndex.value == 0 ||
      currentIndex.value == 1 ||
      currentIndex.value == 2);

  @override
  void onInit() {
    super.onInit();
    tabController.addListener(() {
      if (tabController.page != null) {
        currentIndex(tabController.page!.round());
      }
    });
  }

  void onBottomNavigationTap(int value) {
    currentIndex(value);
    gotoPage(value);
    if (value == 4) {
      showDialog(
        context: Get.context!,
        builder: (context) {
          return const Center(child: EmergencyAlarmRing());
        },
      );
    }
  }

  void gotoPage(int value) {
    tabController.animateToPage(
      value,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  void onPageChanged(int value) {
    currentIndex(value);
  }

  void gotoSettings() {
    Get.toNamed(SettingsPage.routeName);
  }

  void gotoContactSelect() {
    Get.toNamed(ContactSelectPage.routeName);
  }

  void onChatSelectionSelected(bool value) {
    enableChatSelection(value);
  }

  void onArchiveChat() {
    ChatsController.get().onArchiveChat();
  }

  void onBackPressed() {
    if (enableChatSelection.isTrue) {
      enableChatSelection(false);
    } else {
      Get.back();
    }
  }

  void onDeletePressed() {
    AppDialog.showDialog(
      title: 'Delete this chat?',
      secondaryText: 'Delete',
      onSecondaryPressed: Get.back,
      primaryText: 'Cancel',
      onPrimaryPressed: () {
        Get.back();
      },
    );
  }

  void gotoStarredMessages() {
    Get.toNamed(StarredChatsPage.routeName);
  }
}
