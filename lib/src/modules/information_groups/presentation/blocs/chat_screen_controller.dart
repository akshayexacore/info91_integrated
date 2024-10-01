import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/chat_screen/info_group_chat_screen.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';

import 'package:intl/intl.dart';
import 'package:xid/xid.dart';
import 'dart:math';

class ChatScreenController extends GetxController {
  var isEmojiVisible = false.obs;
  RxBool isGalleryVisible = false.obs;
  final ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  var selectedMessage = <ChatMessage>[].obs;

  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    super.dispose();
    _disposeOverlayEntry();
  }

  void _disposeOverlayEntry() {
    _overlayEntry
      ?..remove()
      ..dispose();
    _overlayEntry = null;
  }

  final emojis = const [
    Emoji('👍', 'Thumbs Up', hasSkinTone: true),
    Emoji('❤️', 'Red Heart'),
    Emoji('😂', 'Face With Tears of Joy'),
    Emoji('😭', 'Loudly Crying Face'),
    Emoji('👎', 'Thumbs Down', hasSkinTone: true),
  ];

  RxList<ChatMessage> messages = [
    ChatMessage(
        message: "Good Morning, Have a Good Day!",
        id: "1",
        senderId: "2",
        time: "1:00 PM",
        status: MessageStatus.read,
        messageType: MessageType.image,
        isRead: true,
        dateTime: DateTime.now()),
    ChatMessage(
        message: "Good Morning !",
        senderId: "1",
        id: " 2",
        time: "1:00 PM",
        isRead: false,
        status: MessageStatus.read,
        messageType: MessageType.text,
        dateTime: DateTime.now()),
    ChatMessage(
        message: "https://pub.dev/packages/linkify!",
        senderId: "2",
        isRead: true,
        id: "3",
        status: MessageStatus.delivered,
        time: "1:00 PM",
        messageType: MessageType.text,
        dateTime: DateTime.now()),
    ChatMessage(
        message: "https://chatgpt.com/c/a49ae773-f7cd-477c-a7ab-5cca063d47d7",
        senderId: "1",
        messageType: MessageType.text,
        time: "1:00 PM",
        id: "4",
        isRead: false,
        status: MessageStatus.delivered,
        dateTime: DateTime.now())
  ].obs;

  final picker = ImagePicker();
  var isTextFieldEmpty = true.obs;

  void toggleEmojiPicker() {
    isEmojiVisible.value = !isEmojiVisible.value;

    if (isEmojiVisible.value) {
      isGalleryVisible.value = false;
    }
  }

  void checkTextFieldEmpty(String text) {
    isTextFieldEmpty.value = text.trim().isEmpty;
  }

  void toggleGallery() {
    isGalleryVisible.value = !isGalleryVisible.value;
    if (isGalleryVisible.value) {
      isEmojiVisible.value = false;
    }
  }

  void hideEmojiPicker() {
    isEmojiVisible.value = false;
  }

  bool isTextfielIsEmty(String val) {
    return val.isEmpty;
  }

  void hideGallery() {
    isGalleryVisible.value = false;
  } //imageanddocumenandvideoselctionfunction var imageFile = Rx<File?>(null);

  void sendMessage(MessageType type, {List<Contact>? contactList}) {
    _disposeOverlayEntry();
    var xid = Xid();
    print(xid);
    messages.insert(
        0,
        ChatMessage(
            messageType: type,
            message: searchController.text,
            senderId: "1",
            id: "$xid",
            contactList: contactList,
            time: getCurrentTime(),
            status: MessageStatus.sent,
            dateTime: DateTime.now()));
    scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  String getCurrentTime() {
    final now = DateTime.now();
    final formatter =
        DateFormat.jm(); // This formats the time as '1:00 PM' or '2:30 AM'
    return formatter.format(now);
  }

//handling both selction and deltion and tap and long press in sllection method
  messageOntapfunction(int index, {bool isOntap = false, Offset? position}) {
    if (isOntap) {
      _disposeOverlayEntry();
      if (messages[index].isSelcted == true) {
        selectedMessage.removeWhere((message) {
          return messages[index].id == message.id;
        });
      } else if (checkSelcetionExist()) {
        selectedMessage.add(messages[index]);
      }
    } else {
      if (selectedMessage.isEmpty) {
        _showOverlay(position!, index);
      } else {
        _disposeOverlayEntry();
      }
   
          
      if (selectedMessage.any((message) => message.id == messages[index].id)) {
        selectedMessage
            .removeWhere((message) => message.id == messages[index].id);
      } else {
        selectedMessage.add(messages[index]);
      }
    }
    messages[index] = messages[index].copyWith(
        isSelcted: isOntap
            ? checkSelcetionExist()
                ? !messages[index].isSelcted
                : false
            : !messages[index].isSelcted);

    print("selectedMessage$selectedMessage");
  }

  int messageSelectedcount() {
    int selectedCount = 0;
    selectedCount = messages.fold(0, (i, f) => f.isSelcted ? i + 1 : i);

    return selectedCount;
  }

  //selected message only contain text checkig function
  bool checkOnlySelectedMessageIsText() {
    for (var message in selectedMessage) {
      if (message.messageType != MessageType.text) {
        return false;
      }
    }
    return true;
  }

  bool checkSelcetionExist() {
    for (var message in messages) {
      if (message.isSelcted) {
        return true;
      }
    }
    return false;
  }

  void copySelectedMessages(BuildContext context) {
    _disposeOverlayEntry();
    if (checkOnlySelectedMessageIsText()) {
      String copiedText = selectedMessage.map((id) => id.message).join('\n');
      print("object$copiedText");
      Clipboard.setData(ClipboardData(text: copiedText));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Messages copied')),
      );

      selectedMessage.clear();
      for (var i = 0; i < messages.length; i++) {
        messages[i] = messages[i].copyWith(isSelcted: false);
      }
    }
  }

  void _showOverlay(Offset position, int index) {
    double height = 40.0;

    double dx = min(Get.mediaQuery.size.width - 180, position.dx);

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned(
            top: position.dy - (height - 4),
            left: dx,
            child: SizedBox(
              height: height,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadii.medium),
                    color: AppColors.white,
                  ),
                  child: Row(
                    children: emojis
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(5),
                            child: AppInkWell(
                              borderRadius: 10,
                              onTap: () {
                                if (messages[index].reaction == e.emoji) {
                                  messages[index].reaction = '';
                                } else {
                                  messages[index].reaction = e.emoji;
                                }
                                //chats.refresh();
                                selectedMessage.clear();
                                _disposeOverlayEntry();
                              },
                              child: SizedBox(
                                height: 26,
                                width: 26,
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      e.emoji,
                                      style: const TextStyle(fontSize: 26),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(Get.overlayContext!).insert(_overlayEntry!);
  }
}
