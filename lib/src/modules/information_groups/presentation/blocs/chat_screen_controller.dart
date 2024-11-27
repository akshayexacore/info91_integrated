import 'dart:async';
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/informationgroup/chat_model.dart';
import 'package:info91/src/models/informationgroup/group_profile.dart';
import 'package:info91/src/modules/chat_info/chat_info_page.dart';
import 'package:info91/src/modules/forward/forward_page.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/chat_screen/info_group_chat_screen.dart';
import 'package:info91/src/resources/infromation_repository.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';

import 'package:intl/intl.dart';
import 'package:xid/xid.dart';
import 'dart:math';

class ChatScreenController extends GetxController {
  var isEmojiVisible = false.obs;
  RxBool isGalleryVisible = false.obs;
  final ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  String selectedGroupId = '';
  final _infromationRepository = InfromationRepository();
  get selectedMoreThanOne => selectedMessage.length != 1;
  List<Map<String, dynamic>> messagesData = [
    {
      "message_id": "20241107140957348901b9",
      "user_id": "31",
      "type": "text",
      "message": "vh",
      "message_status": "send",
      "created_at": "2024-11-07 14:09:57",
      "reply_flag": false,
      "reaction_flag": false,
      "image":
          "https://info91.co.in/public/profile_pic/31_1730007041_image_cropper_1730007004159.jpg",
      "phone_number": "9567441600",
      "name": "Akshay",
      "reply_user_id": null,
      "reply_type": null,
      "reply_user_name": null,
      "reply_user_phone_number": null,
      "contact_list": [],
      "date": "2024-11-07",
      "time": "02:09 PM",
      "is_me": true,
      "filesize": null,
      "filename": null,
      "filetype": null,
      "filepages": 0,
      "reply_details": {
        "message_id": null,
        "message": null,
        "type": null,
        "user_id": null,
        "name": null,
        "phone_number": null,
        "reply_is_me": false
      }
    },
    {
      "message_id": "2024110709320493135299",
      "user_id": "31",
      "type": "image",
      "message": "https://info91.co.in/public/upload_files/1730952124_31.jpg",
      "message_status": "send",
      "created_at": "2024-11-07 09:32:04",
      "reply_flag": false,
      "reaction_flag": false,
      "image":
          "https://info91.co.in/public/profile_pic/31_1730007041_image_cropper_1730007004159.jpg",
      "phone_number": "9567441600",
      "name": "Akshay",
      "reply_user_id": null,
      "reply_type": null,
      "reply_user_name": null,
      "reply_user_phone_number": null,
      "contact_list": [],
      "date": "2024-11-07",
      "time": "09:32 AM",
      "is_me": true,
      "filesize": "0.02 MB",
      "filename": "1730952124_31.jpg",
      "filetype": "jpg",
      "filepages": 0,
      "reply_details": {
        "message_id": null,
        "message": null,
        "type": null,
        "user_id": null,
        "name": null,
        "phone_number": null,
        "reply_is_me": false
      }
    },
    {
      "message_id": "2024110709314983467050",
      "user_id": "31",
      "type": "text",
      "message": "hhh",
      "message_status": "send",
      "created_at": "2024-11-07 09:31:49",
      "reply_flag": false,
      "reaction_flag": false,
      "image":
          "https://info91.co.in/public/profile_pic/31_1730007041_image_cropper_1730007004159.jpg",
      "phone_number": "9567441600",
      "name": "Akshay",
      "reply_user_id": null,
      "reply_type": null,
      "reply_user_name": null,
      "reply_user_phone_number": null,
      "contact_list": [],
      "date": "2024-11-07",
      "time": "09:31 AM",
      "is_me": true,
      "filesize": null,
      "filename": null,
      "filetype": null,
      "filepages": 0,
      "reply_details": {
        "message_id": null,
        "message": null,
        "type": null,
        "user_id": null,
        "name": null,
        "phone_number": null,
        "reply_is_me": false
      }
    },
    {
      "message_id": "20241107093145178070bd",
      "user_id": "31",
      "type": "text",
      "message": "hello",
      "message_status": "send",
      "created_at": "2024-11-07 09:31:45",
      "reply_flag": false,
      "reaction_flag": false,
      "image":
          "https://info91.co.in/public/profile_pic/31_1730007041_image_cropper_1730007004159.jpg",
      "phone_number": "9567441600",
      "name": "Akshay",
      "reply_user_id": null,
      "reply_type": null,
      "reply_user_name": null,
      "reply_user_phone_number": null,
      "contact_list": [],
      "date": "2024-11-07",
      "time": "09:31 AM",
      "is_me": true,
      "filesize": null,
      "filename": null,
      "filetype": null,
      "filepages": 0,
      "reply_details": {
        "message_id": null,
        "message": null,
        "type": null,
        "user_id": null,
        "name": null,
        "phone_number": null,
        "reply_is_me": false
      }
    },
    {
      "message_id": "2024110214155447420bb",
      "user_id": "47",
      "type": "text",
      "message": "tata bye bye",
      "message_status": "send",
      "created_at": "2024-11-02 02:45:55",
      "reply_flag": false,
      "reaction_flag": false,
      "image": "https://info91.co.in/public/profile_pic/47_1729923603_2.png",
      "phone_number": "9633719888",
      "name": "Sandeep",
      "reply_user_id": null,
      "reply_type": null,
      "reply_user_name": null,
      "reply_user_phone_number": null,
      "contact_list": [],
      "date": "2024-11-02",
      "time": "02:45 AM",
      "is_me": false,
      "filesize": null,
      "filename": null,
      "filetype": null,
      "filepages": 0,
      "reply_details": {
        "message_id": null,
        "message": null,
        "type": null,
        "user_id": null,
        "name": null,
        "phone_number": null,
        "reply_is_me": false
      }
    },
    {
      "message_id": "20241102131450486602f3",
      "user_id": "31",
      "type": "text",
      "message": "Muthumani",
      "message_status": "send",
      "created_at": "2024-11-02 02:44:50",
      "reply_flag": false,
      "reaction_flag": false,
      "image":
          "https://info91.co.in/public/profile_pic/31_1730007041_image_cropper_1730007004159.jpg",
      "phone_number": "9567441600",
      "name": "Akshay",
      "reply_user_id": null,
      "reply_type": null,
      "reply_user_name": null,
      "reply_user_phone_number": null,
      "contact_list": [],
      "date": "2024-11-02",
      "time": "02:44 AM",
      "is_me": true,
      "filesize": null,
      "filename": null,
      "filetype": null,
      "filepages": 0,
      "reply_details": {
        "message_id": null,
        "message": null,
        "type": null,
        "user_id": null,
        "name": null,
        "phone_number": null,
        "reply_is_me": false
      }
    },
  ];

  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  var isLoading = false.obs;

  late ChatMessage replyChat;
  Timer? chatFetchTimer;
  final int fetchIntervalSeconds = 2;
  var isReplay = false.obs;
  var selectedMessage = <ChatMessage>[].obs;
  var groupProfileModel = GroupProfileModel().obs;
  Map<String, GlobalKey> messageKeys = {};

  OverlayEntry? _overlayEntry;
  final emojis = const [
    Emoji('👍', 'Thumbs Up', hasSkinTone: true),
    Emoji('❤️', 'Red Heart'),
    Emoji('😂', 'Face With Tears of Joy'),
    Emoji('😭', 'Loudly Crying Face'),
    Emoji('👎', 'Thumbs Down', hasSkinTone: true),
  ];

  final picker = ImagePicker();
  var isTextFieldEmpty = true.obs;
  @override
  void onInit() {
    messages.forEach((msg) {
      messageKeys[msg?.userId ?? ""] = GlobalKey();
    });
    // viewMessage();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    _disposeOverlayEntry();
    chatFetchTimer?.cancel();
     chatFetchTimer = null;
  }

  void _disposeOverlayEntry() {
    _overlayEntry
      ?..remove()
      ..dispose();
    _overlayEntry = null;
  }

  void startFetchingChats() {
    // chatFetchTimer = Timer.periodic(
    //   Duration(seconds: fetchIntervalSeconds),
    //   (_) =>
    //   viewMessage(),
    // );
     viewMessage();
  }

  void addMessages() {
    // Parse each JSON message and add to the chatMessages RxList
    messages.addAll(
        messagesData.map((json) => ChatMessage.fromJson(json)).toList());
  }

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

  void scrollToMessage(String messageId) {
    print("messag id$messageId");
    final key = messageKeys[messageId];
    print("messag key$key");
    if (key != null) {
      final context = key.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void sendMessage(MessageType type, {List<Contact>? contactList}) {
    _disposeOverlayEntry();
    var xid = Xid();
    print(xid);
    // messages.insert(
    //     0,
    //     ChatMessage(
    //         messageType: type,
    //         message: searchController.text,
    //         isReplay: isReplay.value,
    //         replyModel: isReplay.value ? replyChat : null,
    //         senderId: "1",
    //         userName: "",
    //         id: "$xid",
    //         contactList: contactList,
    //         time: getCurrentTime(),
    //         status: MessageStatus.sent,
    // dateTime: DateTime.parse(getCurrentDate())));

    isReplay.value = false;
    scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> sendMessage1(String type, {dynamic? messsageType,String? groupId}) async {
    _disposeOverlayEntry();
    var xid = Xid();

    final response = await _infromationRepository.sendMessage(
        groupId: groupId??selectedGroupId,
        type: type,
        message: messsageType ?? searchController.text.trim(),
        replyFlag: isReplay.value,
        reply_message_id: isReplay.value ? replyChat.messageId : null);
    print("calliing sendmessage1${response.data1}");
    if (response.data1) {
      messages.value = response.data2;
      print("calliing sendmessage1${messages.value.length}");

      isReplay.value = false;
      scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {}
  }

  Future<void> viewMessage() async {
    final response = await _infromationRepository.viewMessage(
      groupId: selectedGroupId,
    );

    if (response.data1) {
      messages.value = response.data2;

      // isReplay.value = false;
      // scrollController.animateTo(
      //   0.0,
      //   duration: Duration(milliseconds: 300),
      //   curve: Curves.easeOut,
      // );
    } else {
      messages.clear();
    }

    isLoading.value = false;
  }

  Future<void> fileUpload(String file, String type,{String? groupId}) async {
    final response = await _infromationRepository.fileUpload(
      file: file,
    );
print("sssreragsgddddddddddddddddd$response");
    if (response.data1) {
      sendMessage1(type, messsageType: response.data2["fileName"],groupId: groupId);
    } else {}
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
      print("this case 1");
      if (messages[index].isSelcted == true) {
        print("this case true");
        print("this case ${selectedMessage.length}");
        selectedMessage.removeWhere((message) {
          return messages[index].messageId == message.messageId;
        });
        print("this case 1${selectedMessage.length}");
      } else if (checkSelcetionExist()) {
        selectedMessage.add(messages[index]);
      }
    } else {
      if (selectedMessage.isEmpty) {
        _showOverlay(position!, index);
      } else {
        _disposeOverlayEntry();
      }

      if (selectedMessage
          .any((message) => message.userId == messages[index].userId)) {
        selectedMessage.removeWhere(
            (message) => message.messageId == messages[index].messageId);
      } else {
        selectedMessage.add(messages[index]);
      }
    }
    messages[index] = messages[index].copyWith(
        isSelected: isOntap
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
      if (message.type != MessageType.text) {
        return false;
      }
    }
    return true;
  }

  void onReplyPressed() {
    _disposeOverlayEntry();
    try {
      final chat = messages.firstWhere(
        (element) => element.messageId == selectedMessage.first.messageId,
      );
      isReplay.value = true;
      selectedMessage.clear();
      reSetSelctionMessageList();
      replyChat = chat;
    } catch (_) {}
  }

  void onCloseReply() {
    _disposeOverlayEntry();

    isReplay.value = false;
  }

  bool checkSelcetionExist() {
    // for (var message in messages) {
    //   if (message.isSelcted) {
    //     return true;
    //   }
    // }
    // return false;
    return selectedMessage.isNotEmpty;
  }

  void onForwardPressed() {
    _disposeOverlayEntry();
    Get.toNamed(ForwardPage.routeName)?.then((value) {
      if (value is bool && value) {
        selectedMessage.clear();
        reSetSelctionMessageList();
      }
    });
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
        messages[i] = messages[i].copyWith(isSelected: false);
      }
    }
  }

  deleteSelectedMessage() {
    AppDialog.showDialog(
      title: 'Delete selected messages?',
      primaryText: 'Delete ',
      tertiaryText: "cancel",
      arrangeButtonVertically: true,
      onPrimaryPressed: () {
        _deleteSelected();
        Get.back();
      },
      onSecondaryPressed: () {
        _deleteSelected();
        Get.back();
      },
      onTertiaryPressed: () {
        Get.back();
      },
    );
  }

  Future<void> _deleteSelected() async {
    _disposeOverlayEntry();
    final response = await _infromationRepository.deleTeMessages(
        groupId: selectedGroupId,
        messageIds: selectedMessage.value.map((e) => e.messageId).toList());
    if (response.data1) {
      selectedMessage.value = [];
      messages.value = response.data2;
      AppDialog.showSnackBar('Scuccess ', "message deleted Successfully");
    } else {
      AppDialog.showSnackBar('Failed ', response.data2);
    }
    // messages.removeWhere((item) => item?.isSelcted == true);
    selectedMessage.clear();
  }

  void onInfoPressed() {
    _disposeOverlayEntry();
    final chat = messages.firstWhere(
      (element) => element.userId == selectedMessage.first.userId,
    );
    Get.toNamed(
      ChatInfoPage.routeName,
      arguments: chat,
    );
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
                                  messages[index] =
                                      messages[index].copyWith(reaction: "");
                                } else {
                                  messages[index] = messages[index]
                                      .copyWith(reaction: e.emoji);
                                }
                                //chats.refresh();
                                selectedMessage.clear();
                                _disposeOverlayEntry();
                                reSetSelctionMessageList();
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

  void onBackButtonPress() {
    _disposeOverlayEntry();
    if (selectedMessage.isEmpty) {
      Get.back(result: true);
    } else {
      selectedMessage.clear();
      reSetSelctionMessageList();
    }
  }

  void reSetSelctionMessageList() {
    for (int i = 0; i < messages.length; i++) {
      if (messages[i].isSelcted) {
        messages[i] = messages[i].copyWith(isSelected: false);
      }
    }
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}
