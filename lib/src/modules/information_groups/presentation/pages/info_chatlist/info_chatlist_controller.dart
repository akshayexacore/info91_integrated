import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/models/informationgroup/information_group.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/chat_list_card.dart';
import 'package:info91/src/resources/infromation_repository.dart';

class InfoChatListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
   final _infromationRepository = InfromationRepository();
   var serchController=TextEditingController().obs;
  var toggleValue = 0.obs;
 var ownchatGroupList=<InfoGroupChatListModel>[].obs;
  var chatGroupList=<InfoGroupChatListModel>[].obs;
   var searchGroupList=<InfoGroupChatListModel>[].obs;
  Timer? _debounce;
  var chats = [
    Chat(
      name: "John Doe",
      itemcount: 5,
      message: "Hey! How's it going?",
      time: "12:45 PM",
      avatarUrl: "https://randomuser.me/api/portraits/men/1.jpg",
    ),
    Chat(
      name: "Jane Smith",
      message: "Can we meet tomorrow?",
      time: "11:30 AM",
      avatarUrl: "https://randomuser.me/api/portraits/women/1.jpg",
    ),
    // Add more chats here
  ].obs;
  @override
  void onInit() {
    grtInfoGroupList();
    // TODO: implement onInit
    super.onInit();
  }

  grtInfoGroupList()async {
    
    try {
      final responseData=await _infromationRepository.grtInfoGroupList();
      debugPrint("responseData$responseData");;

      if(responseData!=null){
        chatGroupList.clear();
        ownchatGroupList.clear();
       for (var item in responseData) {
        switch (item.owngroupFlag??false) {
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
      throw (e);
    }
  }


searchInfoGroup(String value){
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final response=await _infromationRepository.searchInfoGroup(value);
      searchGroupList.value=response??[];
     
    });
}
}
