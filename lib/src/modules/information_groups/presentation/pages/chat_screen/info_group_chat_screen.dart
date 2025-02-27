import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/configs/filepicker.dart';
import 'package:info91/src/configs/variables.dart';
import 'package:info91/src/modules/chat/grouped_list.dart';
import 'package:info91/src/modules/information_groups/presentation/blocs/chat_screen_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/chat_screen/build_message_widget.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/chat_screen/contact_list.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/profile_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/chat_list_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_popupmenu.dart';
import 'package:info91/src/widgets/custom/app_app_bar.dart';
import 'package:info91/src/widgets/custom/build_appbar_widgets.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/custom/reply_chat_message_tile.dart';
import 'package:info91/src/widgets/tiny/app_back_button.dart';

import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final ChatScreenController chatController = Get.put(ChatScreenController());
  FocusNode searchFocusnOde = FocusNode();
  FilePickerHelper filePickerHelper = FilePickerHelper();

  Animation<Offset>? _animation;
  AnimationController? _animationController1;
  Tween<Offset>? _animationTween;
  String msgdate = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // this for to get contact litinitial,to avoid lag
    searchFocusnOde.addListener(() {
      if (searchFocusnOde.hasFocus) {
        chatController.hideEmojiPicker();
        chatController.hideGallery();
      }
    });
    _animationController1 = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animationTween = Tween<Offset>(
      begin: Offset(2, -1),
      end: Offset(2, .2),
    );
    _animation = _animationTween!.animate(
      CurvedAnimation(
        parent: _animationController1!,
        curve: Curves.ease,
      ),
    );
  }

  String formatMessageTimestamp(DateTime timestamp, int index) {
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    DateTime lastWeek =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday + 6));
    // if (!checkUniqueness==true) {
    //   // If checkUniqueness is false, return null without checking the uniqueness of the date.
    //   return "";
    // }
    print("date $now");
    if (timestamp.year == now.year &&
        timestamp.month == now.month &&
        timestamp.day == now.day) {
      return ' Today ';
    } else if (timestamp.year == yesterday.year &&
        timestamp.month == yesterday.month &&
        timestamp.day == yesterday.day) {
      return 'Yesterday ';
    } else if (timestamp.isAfter(lastWeek)) {
      return DateFormat('EEEE').format(timestamp);
    } else {
      return DateFormat('d MMM yyyy').format(timestamp);
    }
  }

  Widget buildShowDate() {
    return AnimatedBuilder(
        animation: _animation!,
        builder: (context, child) {
          return Transform.translate(
            offset: _animation!.value,
            child: child,
          );
        },
        child: Container(
            padding: EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
            constraints: BoxConstraints(maxWidth: 110, maxHeight: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: msgdate != ""
                  ? Color.fromARGB(209, 199, 219, 235)
                  : Colors
                      .transparent, // Consider adjusting the color as needed
            ),
            child: Center(
              child: Container(
                  child: Text(
                msgdate,
                textAlign: TextAlign.center,
              )),
            )));
  }

  @override
  Widget build(BuildContext context) {
    final bool canPop = ModalRoute.of(context)?.canPop ?? false;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          if (chatController.isEmojiVisible.value ||
              chatController.isGalleryVisible.value) {
            chatController.hideEmojiPicker();
            chatController.hideGallery();
          } else {
            Navigator.pop(context);
          }
          ;
          return Future.value(false);
        },
        child: Obx(
          () => Scaffold(
            backgroundColor: AppColors.offWhite,
            body: Column(
              children: [
                //AppBAr
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: chatController.selectedMessage.isEmpty
                      ? CustomAppBar(
                          onBackButtonPress: () {
                            chatController.onBackButtonPress();
                          },
                          isPic: chatController.messageSelectedcount() != 0
                              ? false
                              : true,
                          imageUrl: "",
                          imageOntap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(),
                                ));
                          },
                          appBarName: "Information Groups",
                          actionWidget: [
                            if (chatController.messageSelectedcount() != 0) ...[
                              if (chatController
                                  .checkOnlySelectedMessageIsText())
                                IconButton(
                                  onPressed: () {
                                    chatController
                                        .copySelectedMessages(context);
                                  },
                                  icon: Icon(Icons.copy),
                                  color: AppColors.white,
                                ),
                              CustomPopupmenu(
                                  onSelected: (value) {
                                    if (value == 1) {}
                                    if (value == 2) {
                                      chatController.messages.removeWhere(
                                          (item) => item?.isSelcted == true);
                                    }
                                  },
                                  itemList: [
                                    popupMenuModel(
                                        name: chatController
                                                    .messageSelectedcount() ==
                                                1
                                            ? "Copy"
                                            : "Delete",
                                        value: chatController
                                                    .messageSelectedcount() ==
                                                1
                                            ? 1
                                            : 2)
                                  ])
                            ]
                          ],
                        )
                      : _buildSelectedAppBar(
                          canPop: canPop,
                          key: const Key('_buildInfoSelectedAppBar'),
                          selectedCount:
                              chatController.selectedMessage.length.toString()),
                ),

                Expanded(
                  child: Obx(() {
                    debugPrint(chatController.messages.isEmpty.toString());
                    return GroupedList<ChatMessage, DateTime>(
                        controller: chatController.scrollController,
                        elements: chatController.messages,
                        groupBy: (element) => element.dateTime,
                        groupComparator: (value1, value2) =>
                            value1.compareTo(value2),
                        groupHeaderBuilder: (index) => Column(
                              children: [
                                const SizedBox(
                                  height: AppSpacings.small10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppPaddings.xSmall,
                                    vertical: AppPaddings.xxxSmall4,
                                  ),
                                  child: Text(
                                    DateFormat("MMM dd, yyyy").format(
                                        chatController
                                            .messages[index].dateTime),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: AppSpacings.small10,
                                ),
                              ],
                            ),
                        indexedItemBuilder: (context, index) {
                          final message = chatController.messages[index];
                          bool isMe = message.senderId == "1";
                          msgdate =
                              formatMessageTimestamp(message.dateTime, index);

                          return LayoutBuilder(builder: (context, constraints) {
                            return InkWell(
                              highlightColor: AppColors.transparent,
                              splashColor: AppColors.transparent,
                              onTap: () {
                                chatController.messageOntapfunction(index,
                                    isOntap: true);
                              },
                              onLongPress: () {
                                var position;
                                RenderBox? box =
                                    context.findRenderObject() as RenderBox?;
                                if (box != null) {
                                  position = box.localToGlobal(Offset.zero);
                                }
                                chatController.messageOntapfunction(index,
                                    position: position);
                              },
                              child: Stack(
                                children: [
                                  Align(
                                      alignment: isMe
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: BuildMessageWidget(
                                        messageModel: message,
                                      )),
                                  if (chatController.messages[index].isSelcted)
                                    Positioned.fill(
                                      child: Container(
                                          color: AppColors.primary
                                              .withOpacity(0.1)),
                                    )
                                ],
                              ),
                            );
                          });
                        });
                  }),
                ),

                // Expanded(
                //   child:
                //       // Container(color: Colors.red,)
                //       Align(
                //     alignment: Alignment.topCenter,
                //     child: ListView.builder(
                //       controller: chatController.scrollController,
                //       itemCount: chatController.messages.length,
                //       reverse: true,
                //       physics: AlwaysScrollableScrollPhysics(),
                //       shrinkWrap: true,
                //       itemBuilder: (context, index) {
                //         final message = chatController.messages[index];
                //         bool isMe = message.senderId == "1";
                //         msgdate =
                //             formatMessageTimestamp(message.dateTime, index);

                //         return LayoutBuilder(builder: (context, constraints) {
                //           return InkWell(
                //             highlightColor: AppColors.transparent,
                //             splashColor: AppColors.transparent,
                //             onTap: () {
                //               chatController.messageOntapfunction(index,
                //                   isOntap: true);
                //             },
                //             onLongPress: () {
                //               var position;
                //               RenderBox? box =
                //                   context.findRenderObject() as RenderBox?;
                //               if (box != null) {
                //                 position = box.localToGlobal(Offset.zero);
                //               }
                //               chatController.messageOntapfunction(index,
                //                   position: position);
                //             },
                //             child: Stack(
                //               children: [
                //                 Align(
                //                     alignment: isMe
                //                         ? Alignment.centerRight
                //                         : Alignment.centerLeft,
                //                     child: BuildMessageWidget(
                //                       messageModel: message,
                //                     )),

                //                 if (chatController.messages[index].isSelcted)
                //                   Positioned.fill(
                //                     child: Container(
                //                         color:
                //                             AppColors.primary.withOpacity(0.1)),
                //                   )
                //               ],
                //             ),
                //           );
                //         });
                //       },
                //     ),
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: AppColors.white),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Obx(() {
                          return _buildInputField(
                            chatController.searchController,
                            searchFocusnOde,
                            () {
                              chatController.sendMessage(MessageType.text);
                              chatController.searchController.clear();

                              setState(() {});
                            },
                            showReply: chatController.isReplay.value,
                          );
                        }),
                      ),
                      Obx(() => chatController.isEmojiVisible.value
                          ? _buildEmojiPicker()
                          : chatController.isGalleryVisible.value
                              ? bottomSheet(context)
                              : Container()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<dynamic> contacts = [];
  String getCurrentTime() {
    final now = DateTime.now();
    final formatter =
        DateFormat.jm(); // This formats the time as '1:00 PM' or '2:30 AM'
    return formatter.format(now);
  }

  Widget _buildEmojiPicker() {
    return EmojiPicker(
        onEmojiSelected: (category, emoji) {
          chatController.searchController.text =
              chatController.searchController.text + emoji.emoji;
          chatController
              .checkTextFieldEmpty(chatController.searchController.text.trim());
        },
        onBackspacePressed: () {
          if (chatController.searchController.text.isNotEmpty) {
            chatController.searchController.text = chatController
                .searchController.text.characters
                .skipLast(1)
                .toString();
            chatController.checkTextFieldEmpty(
                chatController.searchController.text.trim());
          }
        },
        textEditingController: TextEditingController(),
        scrollController: ScrollController(),
        config: Config(
          height: 256,
          checkPlatformCompatibility: true,
          emojiViewConfig: EmojiViewConfig(
            backgroundColor: Colors.transparent,
            // Issue: https://github.com/flutter/flutter/issues/28894
            emojiSizeMax: 28 *
                (foundation.defaultTargetPlatform == TargetPlatform.iOS
                    ? 1.2
                    : 1.0),
          ),
          swapCategoryAndBottomBar: false,
          skinToneConfig: const SkinToneConfig(),
          categoryViewConfig: const CategoryViewConfig(

              // Set the background to yellow
              indicatorColor: AppColors.primary,
              iconColorSelected: AppColors.primary),
          bottomActionBarConfig: const BottomActionBarConfig(
            backgroundColor: AppColors.primary,
            buttonColor: AppColors.primary,
          ),
          searchViewConfig: const SearchViewConfig(
              backgroundColor: AppColors.primary,
              buttonIconColor: AppColors.white),
        ));
  }

  Widget bottomSheet(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 7.5,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: iconCreation(
                    icon: Icons.photo,
                    text: "Photos",
                    color: AppColors.secondary),
                onTap: () {
                  filePickerHelper.pickFiles("image", context, "gallery");
                },
              ),
              InkWell(
                onTap: () {
                  filePickerHelper.pickFiles("MultipleFile", context, "");
                },
                child: iconCreation(
                    icon: Icons.insert_drive_file,
                    text: "Document",
                    color: AppColors.secondary),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactList(
                          contacts: Variables.userContact,
                          onSubmitFunction: (contactList) {
                            print("contactlist$contactList");
                            chatController.sendMessage(MessageType.contact,
                                contactList: contactList);
                          },
                        ),
                      ));

                  // pickFiles("Video", context, "");
                },
                child: iconCreation(
                    icon: Icons.document_scanner,
                    text: "Contacts",
                    color: AppColors.secondary),
              ),
              iconCreation(
                  icon: Icons.location_pin,
                  text: "Location",
                  color: AppColors.secondary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedAppBar(
      {required bool canPop, Key? key, required String selectedCount}) {
    return AppAppBar(
      showSearch: false,
      leadingLeftPadding: false,
      leadingPadding: 10,
      leading: Row(
        children: [
          AppBackButton(
              color: AppColors.white,
              onPressed: () {
                chatController.onBackButtonPress();
              }),
          const SizedBox(
            width: 15,
          ),

          Text(selectedCount,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          // if (true)
          //   Text(
          //     'Online',
          //     style: TextStyle(
          //       color: AppColors.greenAccent,
          //       fontSize: AppFontSizes.xxxSmall,
          //     ),
          //   ),

          // const SizedBox(
          //   width: 8,
          // ),
          // Container(
          //   width: 1,
          //   color: AppColors.white,
          //   height: 20,
          // ),
        ],
      ),
      autoImplyLeading: false,
      action: Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildOption('ic_forward.svg', onPressed: () {
            chatController.onForwardPressed();
          }
              // _controller.onForwardPressed,
              ),
          Obx(() {
            if (!chatController.selectedMoreThanOne) {
              return buildOption('ic_reply.svg', onPressed: () {
                chatController.onReplyPressed();
              });
            }
            return const SizedBox();
          }),
          Obx(() {
            if (chatController.checkOnlySelectedMessageIsText()) {
              return buildOption('ic_content_copy.svg', onPressed: () {
                chatController.copySelectedMessages(context);
              });
            }
            return SizedBox();
          }),
          Obx(() {
            if (!chatController.selectedMoreThanOne) {
              return buildOption('ic_star.svg', onPressed: () {}
                  //  _controller.onStarPressed,
                  );
            }
            return SizedBox();
          }),
          buildOption(
            'ic_delete.svg',
            onPressed: () {
              chatController.deleteSelectedMessage();
            }, // _controller.onDeletePressed,
          ),
          Obx(() {
            if (!chatController.selectedMoreThanOne) {
              return buildOption('ic_info.svg',
                  onPressed: chatController.onInfoPressed);
            }
            return const SizedBox();
          }),
        ],
      ),
    );
  }

  Widget iconCreation(
      {required IconData icon, required Color color, required String text}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            radius: 26.r,
            backgroundColor: color,
            child: Icon(
              icon,
              color: Colors.white,
              size: 29,
            ),
          ),
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _buildInputField(
      TextEditingController controller, FocusNode focusnode, Function onSend,
      {required bool showReply}) {
    var border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(15),
    );
    return Column(
      children: [
        if (showReply)
          ReplyChatMessageTile(
            onClose: (){
              chatController.onCloseReply();
            },
            chatMessage: chatController.replyChat,
            isChatMessage: true,
            message: chatController.replyChat.message,
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 50.h,
                  child: TextField(
                    controller: controller,
                    focusNode: focusnode,
                    onTap: () {
                      chatController.hideEmojiPicker();
                      chatController.hideGallery();
                    },
                    onChanged: (val) {
                      chatController.checkTextFieldEmpty(val);
                    },
                    decoration: InputDecoration(
                      hintText: 'Type your message here',
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 12.5.sp,
                          color: AppColors.text.withOpacity(.75)),
                      filled: true,
                      fillColor: AppColors.google,
                      border: border,
                      errorBorder: border,
                      enabledBorder: border,
                      focusedBorder: border,
                      prefixIcon: Obx(() => IconButton(
                            icon: Icon(
                              chatController.isEmojiVisible.value
                                  ? Icons.keyboard
                                  : Icons.sentiment_satisfied_outlined,
                              color: AppColors.primary,
                              size: 24.sp,
                            ),
                            onPressed: () {
                              chatController.toggleEmojiPicker();
                              print(chatController.isEmojiVisible.value);
                              if (chatController.isEmojiVisible.isTrue) {
                                searchFocusnOde.unfocus(); // Hide the keyboard
                              } else {
                                searchFocusnOde
                                    .requestFocus(); // Show the keyboard
                              }
                            },
                          )),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.attach_file,
                          color: AppColors.primary,
                          size: 24.sp,
                        ),
                        onPressed: chatController.toggleGallery,
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() => IconButton(
                    icon: chatController.isTextFieldEmpty.value
                        ? Icon(
                            Icons.photo_camera_outlined,
                            color: AppColors.primary,
                            size: 24.sp,
                          )
                        : Icon(
                            Icons.send,
                            color: AppColors.primary,
                            size: 24.sp,
                          ),
                    onPressed: () {
                      chatController.isTextFieldEmpty.value
                          ? filePickerHelper.pickFiles("image", context, "")
                          : onSend();
                      chatController
                          .checkTextFieldEmpty(controller.text.trim());
                    },
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

enum MessageType { text, image, document, audio, video, reply, contact }

enum MessageStatus {
  sent,
  delivered,
  read,
}

class ChatMessage {
  final String id;
  final String message;
  final String senderId;
  final bool isRead;
  final String time;
  final DateTime dateTime;

  final MessageType messageType;
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
    required this.messageType,
    this.filePath,
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
    MessageType? messageType,
    MessageStatus? status,
    String? filePath,
    bool? isSelcted,
    String? reaction,
    bool? isReplay,
    List<Contact>? contactList,
  }) {
    return ChatMessage(
      message: message ?? this.message,
      senderId: senderId ?? this.senderId,
      isRead: isRead ?? this.isRead,
      id: id ?? this.id,
      reaction: reaction ?? this.reaction,
      isReplay: isReplay ?? this.isReplay,
      time: time ?? this.time,
      dateTime: dateTime ?? this.dateTime,
      messageType: messageType ?? this.messageType,
      status: status ?? this.status,
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
        dateTime: dateTime,
        id: id,
        messageType: messageType,
        isSelcted: this.isSelcted,
        status: status,
        time: time);
  }
}
