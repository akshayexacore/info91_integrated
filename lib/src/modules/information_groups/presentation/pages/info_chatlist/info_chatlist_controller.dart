import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/models/informationgroup/group_profile.dart';
import 'package:info91/src/models/informationgroup/information_group.dart';

import 'package:info91/src/modules/information_groups/presentation/pages/chat_screen/info_group_chat_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/startscreen/start_screen.dart';

import 'package:info91/src/resources/infromation_repository.dart';

class InfoChatListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  final _infromationRepository = InfromationRepository();
  var serchController = TextEditingController().obs;
  var toggleValue = 0.obs;
  var ownchatGroupList = <InfoGroupChatListModel>[].obs;
  var chatGroupList = <InfoGroupChatListModel>[].obs;
  var searchGroupList = <InfoGroupChatListModel>[].obs;
  Timer? _debounce;
  var loading = false.obs;
  @override
  void onInit() {
    loading.value = true;
    grtInfoGroupList();
    // TODO: implement onInit
    super.onInit();
  }

  grtInfoGroupList() async {
    try {
      loading.value = true;
      final responseData = await _infromationRepository.grtInfoGroupList();
      debugPrint("responseData$responseData");
      ;
      loading.value = false;
      if (responseData != null) {
        chatGroupList.clear();
        ownchatGroupList.clear();
        for (var item in responseData) {
          switch (item.owngroupFlag ?? false) {
            case true:
              ownchatGroupList.add(item);
              break;
            case false:
              chatGroupList.add(item);
              break;
          }
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  searchInfoGroup(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final response = await _infromationRepository.searchInfoGroup(value);
      searchGroupList.value = response ?? [];
    });
  }

  nonPublicTileOnTap(int index) {
    if (toggleValue.value == 0) {
      debugPrint('chatGroupList[index]${chatGroupList[index].id}');
      Get.toNamed(StartScreen.routName,
          arguments: {'group': chatGroupList[index]})?.then((_) {
          // This will be called when you return to the previous page
         
        grtInfoGroupList(); // Call fetchData to refresh the data
        });
    } else {
      Get.to(ChatScreen(
        selectedGroupId: ownchatGroupList[index].id,
        model: GroupProfileModel(
          groupName: ownchatGroupList[index].groupName,
          alternativeNumber: ownchatGroupList[index].alternativeNumber,
        ),
      ))?.then((_) {
          // This will be called when you return to the previous page
         
        grtInfoGroupList(); // Call fetchData to refresh the data
        });
    }
  }
}
