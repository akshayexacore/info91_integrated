import 'package:flutter_contacts/contact.dart';
import 'package:get/get.dart';
import 'package:info91/src/models/chat.dart';


class ChatInfoController extends GetxController {
  final chat = Chat(date: DateTime.now()).obs;
  late ChatMessage chatMessage;
 var isChatType=true.obs;
  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments;






    if (arguments != null ) {
      if(arguments is Chat){
        isChatType.value=true;
        chat(arguments);
      }
      
      if(arguments is ChatMessage){
         isChatType.value=false;
        chatMessage=  arguments;
        print("chatmessssssssssss${chatMessage.id}");
      }
     
    }
  }
}

class ChatMessage {
  final String id;
  final String message;
  final String senderId;
  final bool isRead;
  final String time;
  final String userName;
  final DateTime dateTime;
  final String? userProfile;

  // final MessageType messageType;
  MessageStatus status;
  final String? filePath;
  final bool isSelcted;
  final bool? isReplay;
  String reaction;
  final ChatMessage? replyModel;
  final List<Contact>? contactList;

  ChatMessage({
    this.isReplay,
    required this.id,
    required this.dateTime,
    required this.userName,
    // required this.messageType,
    this.filePath,
    this.userProfile,
    this.replyModel,
    this.contactList,
    required this.time,
    this.reaction = '',
    this.isSelcted = false,
    required this.message,
    required this.senderId,
    required this.status,
    this.isRead = false,
  });

  ChatMessage copyWith({
    String? message,
    String? senderId,
    bool? isRead,
    String? time,
    DateTime? dateTime,
    // MessageType? messageType,
    MessageStatus? status,
    String? filePath,
    bool? isSelcted,
    String? reaction,
    bool? isReplay,
    List<Contact>? contactList,
    String? userNAme,
    String? userProfile,
  }) {
    return ChatMessage(
      message: message ?? this.message,
      senderId: senderId ?? this.senderId,
      isRead: isRead ?? this.isRead,
      id: id ?? this.id,
      userName: userNAme ?? this.userName,
      reaction: reaction ?? this.reaction,
      isReplay: isReplay ?? this.isReplay,
      time: time ?? this.time,
      dateTime: dateTime ?? this.dateTime,
      // messageType: messageType ?? this.messageType,
      status: status ?? this.status,
      userProfile: userProfile ?? this.userProfile,
      filePath: filePath ?? this.filePath,
      isSelcted: isSelcted ?? this.isSelcted,
      contactList: contactList ?? this.contactList,
    );
  }

  // Method to mark the message as read
  ChatMessage markAsRead() {
    return ChatMessage(
        message: message,
        senderId: senderId,
        isRead: true,
        userName: userName,
        dateTime: dateTime,
        userProfile: userProfile,
        id: id,
        // messageType: messageType,
        isSelcted: this.isSelcted,
        status: status,
        time: time);
  }
}
