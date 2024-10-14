import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/chat_list_card.dart';

class InfoChatListController extends GetxController with GetSingleTickerProviderStateMixin{
   ScrollController _scrollController = ScrollController();
   var toggleValue=0.obs;
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
}