import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/models/informationgroup/chat_model.dart';
import 'package:info91/src/models/informationgroup/information_group.dart';
import 'package:info91/src/models/profile.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/info_chatlist/info_chatlist_controller.dart';
import 'package:info91/src/resources/infromation_repository.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';
import 'package:info91/src/widgets/custom/custom_loadre.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ForwardController extends GetxController {
  final chatListController = Get.put(InfoChatListController());
  var contacts = <InfoGroupChatListModel>[].obs;
  var searchValue = "".obs;
  var filtercontacts = <InfoGroupChatListModel>[].obs;
  late final ScrollController scrollController;
  get contactsLength => contacts.length;
  String selectedGroupId = "";
  List<String> selectedMessage = [];
  final selectedContacts = <InfoGroupChatListModel>[].obs;
  final _infromationRepository = InfromationRepository();
  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    _getProfiles();
    _getArguments();
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }
  void _getArguments() {
    if (Get.arguments != null) {
      List<ChatMessage> list = Get.arguments["selected"] ?? [];
      selectedGroupId = Get.arguments["group_id"] ?? "";
      print("group_idsss$selectedGroupId");
      selectedMessage = list.map((e) => e.messageId ?? "").toList();
    }
  }

  void _getProfiles() {
      filtercontacts .clear();
        filtercontacts.clear();
    contacts.value = [...chatListController.ownchatGroupList, ...chatListController.chatGroupList];

    filtercontacts.value = [...chatListController.ownchatGroupList, ...chatListController.chatGroupList];
  }

  void filterContactsFunc(String value) {
    String query = value.toLowerCase();

    filtercontacts.value = contacts.where((contact) {
      final String? groupName = contact.groupName?.toLowerCase();

      return (groupName != null && groupName.contains(query));
    }).toList();
  }

  void gotoChatPage(Profile profile) {}

  void onSelectedContact(InfoGroupChatListModel profile) {
    if (!selectedContacts.contains(profile)) {
      selectedContacts.add(profile);
    } else {
      selectedContacts.remove(profile);
    }
  }

  void onSendPressed() {
    Get.back(
      result: true,
    );
  }

  void searchFunction(String value) {
    searchValue(value);
    filterContactsFunc(value ?? "");
  }

  Future<void> onSend() async {
    try {
      Get.context!.loaderOverlay.show(widgetBuilder: (progress) => CustomLoader(progress: progress,message: "Forwarding...",),progress: 50);
      List<String> groupIds = selectedContacts.map((e) => e.id ?? "").toList();
      debugPrint("the values");
      debugPrint(selectedGroupId);
      debugPrint(groupIds.toString());
      debugPrint(selectedMessage.toString());
      final response = await _infromationRepository.onSend(
          fromGroupUserId: selectedGroupId,
          groupIds: groupIds,
          messageIds: selectedMessage);
      if (response.data1) {
        Get.back(
          result: true,
        );
      } else {
        AppDialog.showToast(
          response.data2,
        );
      }
    } catch (e) {
      debugPrint("the error$e");
      AppDialog.showToast(
        "Something went wrong! Try again.",
      );
    } finally {
      Get.context!.loaderOverlay.hide();
    }
  }
}
