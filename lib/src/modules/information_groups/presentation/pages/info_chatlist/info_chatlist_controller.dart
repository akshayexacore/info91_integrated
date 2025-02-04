import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:info91/src/models/informationgroup/information_group.dart';

import 'package:info91/src/modules/information_groups/presentation/pages/startscreen/start_screen.dart';

import 'package:info91/src/resources/infromation_repository.dart';

class InfoChatListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _infromationRepository = InfromationRepository();
  var serchController = TextEditingController().obs;
  var toggleValue = 0.obs;
  var searchText = "".obs;
  var ownchatGroupList = <InfoGroupChatListModel>[].obs;
  var chatGroupList = <InfoGroupChatListModel>[].obs;
  var searchGroupList = <InfoGroupChatListModel>[].obs;
    var totalGroupList = <InfoGroupChatListModel>[].obs;
  Timer? _debounce;
  var loading = false.obs;
  @override
  void onInit() {
    // loading.value = true;
    grtInfoGroupList();
    // TODO: implement onInit
    super.onInit();
  }

  grtInfoGroupList() async {
    try {
   if(ownchatGroupList.isEmpty  && chatGroupList.isEmpty)   loading.value = true;
      final responseData = await _infromationRepository.grtInfoGroupList();
      totalGroupList.value=responseData;
      // chatGroupList.value=responseData;
      debugPrint("responseData${chatGroupList.value.length}");
      ;
    loading.value = false;
      if (responseData != null) {
        debugPrint("responseDatasss$responseData");
        chatGroupList.clear();
        ownchatGroupList.clear();
        for (var item in responseData) {
          switch (item.owngroupFlag ?? false) {
            case true:
              ownchatGroupList.add(item);
              break;
            case false:
              // chatGroupList.add(item);
              break;
          }
        }
      }
       chatGroupList.value=responseData;
    } catch (e) {
      print("the errro ishere $e");
       loading.value = false;
      rethrow;
    }
  }

  searchInfoGroup(String value) {
  try{
   
       loading.value = true;
      if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final response = await _infromationRepository.searchInfoGroup(value);
      searchGroupList.value = response ?? [];
       loading.value = false;
    });
  }catch(e){
       loading.value = false;

  }
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
      debugPrint(
          "ownchatGroupList[index].profileImage${ownchatGroupList[index].profileImage}");
            Get.toNamed(StartScreen.routName,
          arguments: {'group': ownchatGroupList[index]})?.then((_) {
        // This will be called when you return to the previous page

        grtInfoGroupList(); // Call fetchData to refresh the data
      });
      // Get.to(ChatScreen(
      //   selectedGroupId: ownchatGroupList[index].id,
      //   model: GroupProfileModel(
      //       groupName: ownchatGroupList[index].groupName,
      //       alternativeNumber: ownchatGroupList[index].alternativeNumber,
      //       profileImage: ownchatGroupList[index].profileImage),
      // ))?.then((_) {
      //   // This will be called when you return to the previous page

      //   grtInfoGroupList(); // Call fetchData to refresh the data
      // });
    }
  }
  publicTileOnTap(int index) {
   
      debugPrint('chatGroupList[index]${searchGroupList[index].id}');
      Get.toNamed(StartScreen.routName,
          arguments: {'group': searchGroupList[index]})?.then((_) {
        // This will be called when you return to the previous page

        grtInfoGroupList(); // Call fetchData to refresh the data
      });
    } 
  
}
