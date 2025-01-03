import 'dart:io';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/configs/filepicker.dart';
import 'package:info91/src/models/informationgroup/chat_model.dart';
import 'package:info91/src/modules/information_groups/presentation/blocs/chat_screen_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/chat_screen/contactSelected_view_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/chat_screen/info_group_chat_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/startscreen/start_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/VideoPlayerScreen2.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_popupmenu.dart';

import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/resources/infromation_repository.dart';
import 'package:info91/src/widgets/custom/custom_divider.dart';
import 'package:info91/src/widgets/custom/custom_image_popup.dart';
import 'package:info91/src/widgets/custom/image_view.dart';
import 'package:info91/src/widgets/custom/string_extensions.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';
import 'package:info91/src/widgets/tiny/app_check_box.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:voice_message_package/voice_message_package.dart';

class BuildMessageWidget extends StatelessWidget {
  final ChatMessage messageModel;
  final bool isSameUser;
  final String groupId;
  BuildMessageWidget(
      {super.key,
      required this.messageModel,
      required this.isSameUser,
      required this.groupId});

  @override
  Widget build(BuildContext context) {
    switch (messageModel.type) {
      case "text":
        return _buildTextMessage(messageModel, context, isSameUser: isSameUser);
      case "image":
        return BuildChatImage(
          message: messageModel,
          isSameUser: isSameUser,
          groupId: groupId,
        );
      case "document":
        return _buildDocumentMessage(messageModel, context,
            isSameUser: isSameUser);
      case "audio":
        return _buildAudioMessage(messageModel, context,
            isSameUser: isSameUser);
      case "video":
        return _buildVideoMessage(messageModel, context,
            isSameUser: isSameUser);
      case "reply":
        return _buildReplyMessage(messageModel);
      case "contact":
        return _buildConatctMessage(messageModel, context,
            isSameUser: isSameUser);
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildTextMessage(ChatMessage message, BuildContext context,
      {required bool isSameUser}) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    bool isMe = message.isMe ?? false;
    bool isReplyMe = true;
    return commonBuildMessageOuter(
      message: message,
      context: context,
      isSameUser: isSameUser,
      isMe: isMe,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSameUser && !isMe)
            Text(message.name ?? "",
                style: TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.bold)),
          message.replyFlag == true
              ? Container(
                  width: w / 1.5,
                  padding:
                      EdgeInsets.only(top: 5, right: 5, bottom: 5, left: 7),
                  decoration: BoxDecoration(
                      // border: Border.all(color: ColorPalette.primary),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(7),
                          topLeft: Radius.circular(7)),
                      color: isMe ? AppColors.replyWhite : Color(0xff666666)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          isReplyMe == true
                              ? "you"
                              : "${message.replyDetails?.name.toString().toTitleCase()}",
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary)),
                      Container(
                          child: Stack(
                        children: [
                          Positioned(
                              left: -1,
                              top: 2,
                              child: message.replyDetails?.type == "image"
                                  ? const Icon(
                                      Icons.image,
                                      size: 16,
                                    )
                                  : message.replyDetails?.type == "video"
                                      ? const Icon(
                                          Icons.video_library,
                                          size: 16,
                                        )
                                      : message.replyDetails?.type == "audio"
                                          ? Icon(Icons.mic, size: 16)
                                          : message.replyDetails?.type ==
                                                  "document"
                                              ? Icon(Icons.file_copy, size: 16)
                                              : SizedBox()),
                          message.replyDetails?.type == "text" ||
                                  message.replyDetails?.type ==
                                      MessageType.mention
                              ? Text(
                                  message.replyDetails?.message ?? "",
                                  softWrap: true,
                                  textScaler: TextScaler.linear(1),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    message.replyDetails?.message ?? "",
                                    softWrap: true,
                                    textScaler: TextScaler.linear(1),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                        ],
                      ))
                    ],
                  ),
                )
              : const SizedBox(),
          Linkify(
            linkStyle: GoogleFonts.poppins(decorationColor: Colors.blue),
            onOpen: (link) async {
              if (!await launchUrl(Uri.parse(link.url))) {
                throw Exception('Could not launch ${link.url}');
              }
            },
            text: message.message ?? "",
            textAlign: TextAlign.left,
            style: chatTextstyle,
          ),
          Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.time ?? "",
                  style: GoogleFonts.poppins(
                      color: Color(0xff666666),
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp),
                ),
                SizedBox(
                  width: 1.w,
                ),
                if (isMe) _buildMessageStatus(message.messageStatus ?? ""),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentMessage(ChatMessage message, BuildContext context,
      {required bool isSameUser}) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    bool isMe = message.isMe ?? false;
    bool isReplyMe = message.replyDetails?.replyIsme ?? false;
    return commonBuildMessageOuter(
      message: message,
      context: context,
      isSameUser: isSameUser,
      isMe: isMe,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSameUser && !isMe)
            Text(message.name ?? "",
                style: const TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.bold)),
          message.replyFlag == true
              ? Container(
                  width: w,
                  padding:
                      EdgeInsets.only(top: 5, right: 5, bottom: 5, left: 5),
                  decoration: BoxDecoration(
                      // border: Border.all(color: ColorPalette.primary),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(7),
                          topLeft: Radius.circular(7)),
                      color: isMe ? AppColors.replyWhite : Color(0xff666666)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          isReplyMe == true
                              ? "you"
                              : "${message.replyDetails?.name.toString().toTitleCase()}",
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary)),
                      Container(
                          child: Stack(
                        children: [
                          Positioned(
                              left: -1,
                              top: 2,
                              child: message.replyDetails?.type ==
                                      MessageType.image
                                  ? Icon(
                                      Icons.image,
                                      size: 16,
                                    )
                                  : message.replyDetails?.type ==
                                          MessageType.video
                                      ? Icon(
                                          Icons.video_library,
                                          size: 16,
                                        )
                                      : message.replyDetails?.type ==
                                              MessageType.audio
                                          ? Icon(Icons.mic, size: 16)
                                          : message.replyDetails?.type ==
                                                  MessageType.document
                                              ? Icon(Icons.file_copy, size: 16)
                                              : SizedBox()),
                          message.replyDetails?.type == MessageType.text ||
                                  message.replyDetails?.type ==
                                      MessageType.mention
                              ? Text(
                                  message.replyDetails?.type ?? "",
                                  softWrap: true,
                                  textScaler: TextScaler.linear(1),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    message.replyDetails?.type ?? "",
                                    softWrap: true,
                                    textScaler: TextScaler.linear(1),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                        ],
                      ))
                    ],
                  ),
                )
              : SizedBox(),
          Row(
            children: [
              Icon(
                message?.fileType == "pdf"
                    ? Icons.picture_as_pdf_outlined
                    : message?.fileType == "jpg"
                        ? Icons.image
                        : Icons.insert_drive_file,
                color: AppColors.primary,
                size: 30,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " ${message.message ?? ""} MB ",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          message.fileSize ?? "",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          " .  ${message.fileType ?? ""}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.time ?? "",
                  style: GoogleFonts.poppins(
                      color: Color(0xff666666),
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp),
                ),
                SizedBox(
                  width: 1.w,
                ),
                if (isMe) _buildMessageStatus(message.messageStatus ?? ""),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildDocumentMessage(ChatMessage message) {
  //   return ListTile(
  //     title: Text(message.message??""),
  //     subtitle: Text(message.userId??""),
  //   );
  // }

  Widget _buildAudioMessage(ChatMessage message, BuildContext context,
      {required bool isSameUser}) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    bool isMe = message.isMe ?? false;
    bool isReplyMe = true;
    return commonBuildMessageOuter(
      message: message,
      context: context,
      isSameUser: isSameUser,
      isMe: isMe,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSameUser && !isMe)
            Text(message.name ?? "",
                style: const TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.bold)),
          message.replyFlag == true
              ? Container(
                  width: w / 1.5,
                  padding: const EdgeInsets.only(
                      top: 5, right: 5, bottom: 5, left: 7),
                  decoration: BoxDecoration(
                      // border: Border.all(color: ColorPalette.primary),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(7),
                          topLeft: Radius.circular(7)),
                      color: isMe ? AppColors.replyWhite : Color(0xff666666)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          isReplyMe == true
                              ? "you"
                              : "${message.replyDetails?.name.toString().toTitleCase()}",
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary)),
                      Container(
                          child: Stack(
                        children: [
                          Positioned(
                              left: -1,
                              top: 2,
                              child: message.replyDetails?.type == "image"
                                  ? Icon(
                                      Icons.image,
                                      size: 16,
                                    )
                                  : message.replyDetails?.type == "video"
                                      ? Icon(
                                          Icons.video_library,
                                          size: 16,
                                        )
                                      : message.replyDetails?.type == "audio"
                                          ? Icon(Icons.mic, size: 16)
                                          : message.replyDetails?.type ==
                                                  "document"
                                              ? Icon(Icons.file_copy, size: 16)
                                              : SizedBox()),
                          message.replyDetails?.type == "text" ||
                                  message.replyDetails?.type ==
                                      MessageType.mention
                              ? Text(
                                  message.replyDetails?.message ?? "",
                                  softWrap: true,
                                  textScaler: TextScaler.linear(1),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    message.replyDetails?.message ?? "",
                                    softWrap: true,
                                    textScaler: TextScaler.linear(1),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                        ],
                      ))
                    ],
                  ),
                )
              : const SizedBox(),
          VoiceMessageView(
            circlesColor: AppColors.primary,
            backgroundColor:
                isMe ? AppColors.white : AppColors.primary.withOpacity(.2),
            activeSliderColor: AppColors.primary.withOpacity(.2),
            time: message.time ?? "",
            controller: VoiceController(
              audioSrc: message.message ?? "",
              maxDuration: const Duration(hours: 1),
              isFile: false,
              onComplete: () {},
              onPause: () {},
              onPlaying: () {},
            ),
          )

          // Align(
          //   alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Text(
          //         message.time ?? "",
          //         style: GoogleFonts.poppins(
          //             color: Color(0xff666666),
          //             fontWeight: FontWeight.w400,
          //             fontSize: 11.sp),
          //       ),
          //       SizedBox(
          //         width: 1.w,
          //       ),
          //       if (isMe) _buildMessageStatus(message.messageStatus ?? ""),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildVideoMessage(ChatMessage message, BuildContext context,
      {required bool isSameUser}) {
    double w1 = MediaQuery.of(context).size.width;
    double w = w1 > 700 ? 400 : w1;
    bool isMe = message.isMe ?? false;
    bool isReplyMe = true;
    return commonBuildMessageOuter(
      message: message,
      context: context,
      isSameUser: isSameUser,
      isMe: isMe,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSameUser && !isMe)
            Text(message.name ?? "",
                style:const TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.bold)),
          message.replyFlag == true
              ? Container(
                  width: w / 1.5,
                  padding: const EdgeInsets.only(
                      top: 5, right: 5, bottom: 5, left: 7),
                  decoration: BoxDecoration(
                      // border: Border.all(color: ColorPalette.primary),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(7),
                          topLeft: Radius.circular(7)),
                      color: isMe ? AppColors.replyWhite : Color(0xff666666)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          isReplyMe == true
                              ? "you"
                              : "${message.replyDetails?.name.toString().toTitleCase()}",
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary)),
                      Container(
                          child: Stack(
                        children: [
                          Positioned(
                              left: -1,
                              top: 2,
                              child: message.replyDetails?.type == "image"
                                  ? const Icon(
                                      Icons.image,
                                      size: 16,
                                    )
                                  : message.replyDetails?.type == "video"
                                      ? Icon(
                                          Icons.video_library,
                                          size: 16,
                                        )
                                      : message.replyDetails?.type == "audio"
                                          ? Icon(Icons.mic, size: 16)
                                          : message.replyDetails?.type ==
                                                  "document"
                                              ?const Icon(Icons.file_copy, size: 16)
                                              :const SizedBox()),
                          message.replyDetails?.type == "text" ||
                                  message.replyDetails?.type ==
                                      MessageType.mention
                              ? Text(
                                  message.replyDetails?.message ?? "",
                                  softWrap: true,
                                  textScaler: TextScaler.linear(1),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    message.replyDetails?.message ?? "",
                                    softWrap: true,
                                    textScaler: TextScaler.linear(1),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                        ],
                      ))
                    ],
                  ),
                )
              : SizedBox(),
          VideoMessageBubble(
            isSender: isReplyMe,
            videoDuration: message.fileSize ?? "",
            videoPath: message.message ?? "", videoSize: message.fileSize ?? "",
            timestamp: message.time ?? "",
            onTap: () {
              showVideoPreviewDialog(context, model: message);
            },
            // videoPlayerController:
            //     VideoPlayerController.network(
            //   messageList[index].message ?? "",
            // ),
          ),

          // Align(
          //   alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Text(
          //         message.time ?? "",
          //         style: GoogleFonts.poppins(
          //             color: Color(0xff666666),
          //             fontWeight: FontWeight.w400,
          //             fontSize: 11.sp),
          //       ),
          //       SizedBox(
          //         width: 1.w,
          //       ),
          //       if (isMe) _buildMessageStatus(message.messageStatus ?? ""),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildReplyMessage(ChatMessage message) {
    return ListTile(
      title: Text(message.message ?? ""),
      subtitle: Text(message.userId ?? ""),
    );
  }

  Widget _buildConatctMessage(ChatMessage message, BuildContext context,
      {required bool isSameUser}) {
    int contactListCount = message.contactList?.length ?? 0;
    bool isMe = message.isMe ?? false;
    return commonBuildMessageOuter(
      context: context,
      isMe: isMe,
      message: message,
      isSameUser: isSameUser,
      child: Column(
        children: [
          ListTile(
            leading: AppCustomCirleProfileIamge(
              isStringImag: false,
              memoryImage: null,
              radius: 25.r,
            ),
            title: Text(contactListCount == 1
                ? message.contactList![0].displayName ?? ""
                : "${message.contactList?[0].displayName} and ${contactListCount - 1} others"),
          ),
          Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.time ?? "",
                  style: GoogleFonts.poppins(
                      color: Color(0xff666666),
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp),
                ),
                SizedBox(
                  width: 1.w,
                ),
                if (isMe) _buildMessageStatus(message.messageStatus ?? ""),
              ],
            ),
          ),
          customDivider(clr: AppColors.black),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              customTextButton("View All", clr: AppColors.black, onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectedContactListView(
                          contactList: message.contactList ?? []),
                    ));
              })
            ],
          ),
        ],
      ),
    );
  }
}

class BuildChatImage extends StatefulWidget {
  final ChatMessage message;
  final bool isSameUser;
  final String groupId;
  const BuildChatImage(
      {super.key,
      required this.message,
      required this.isSameUser,
      required this.groupId});

  @override
  State<BuildChatImage> createState() => _BuildChatImageState();
}

class _BuildChatImageState extends State<BuildChatImage> {
  late String _localPath;
  final InfromationRepository _repository = InfromationRepository();
  Map<String, bool> _downloadStatus = {};
  List<customPopupmenuButton> item = [
    customPopupmenuButton(label: "Download", value: "1"),

    // customPopupmenuButton(label: "Channel",value: "2"),
  ];
  Map<String, bool> _downloadloading = {};

  Future<void> _downloadImage(String imageUrl) async {
    try {
      setState(() {
        _downloadloading[imageUrl] = true;
      });
      await _requestPermission();
      final response = await http.get(Uri.parse(imageUrl));
      final directory = await getApplicationDocumentsDirectory();
      _localPath = directory.path;

      final filePath = '$_localPath/${imageUrl.split('/').last}';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
 final val=     await GallerySaver.saveImage(filePath);
 debugPrint("the value of downlaoded file is here$val");
 debugPrint("the value of downlaoded file is here${widget.message.fileDownloadFlag}");
  //  await ImageGallerySaver.saveImage(
  //       Uint8List.fromList(response.bodyBytes),
  //       quality: 80,
  //       name: imageUrl.split('/').last,
  //     );

      if (widget.message.fileDownloadFlag != true){      final data = await _repository.downLoadFiles(
            messageids: widget.message.messageId ?? "",
            groupId: widget.groupId);
             debugPrint("the value of downlaoded file is here$data");}
  
      setState(() {
        _downloadloading[imageUrl] = false;
        _downloadStatus[imageUrl] = true;
        print("download${_downloadStatus[imageUrl]}");
      });
    } catch (e) {
      debugPrint("the image downlaoding error${e}");
    }
  }

  Future<void> requestStoragePermission() async {
    // Check if the platform is Android
    if (Platform.isAndroid) {
      // Check if the device is running Android 11 (API 30) or higher
      if (await _isAndroid11OrHigher()) {
        // Request MANAGE_EXTERNAL_STORAGE for Android 11+
        var status = await Permission.manageExternalStorage.status;
        if (!status.isGranted) {
          status = await Permission.manageExternalStorage.request();
        }
        if (!status.isGranted) {
          print('Manage External Storage permission denied');
          return;
        }
      } else {
        // For Android versions below 11, request storage permission
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          status = await Permission.storage.request();
        }
        if (!status.isGranted) {
          print('Storage permission denied');
          return;
        }
      }
    }
  }

  /// Check if the Android version is 11 (API 30) or higher.
  Future<bool> _isAndroid11OrHigher() async {
    return Platform.isAndroid && (await _getAndroidVersion()) >= 11;
  }

  /// Method to get the current Android version.
  Future<int> _getAndroidVersion() async {
    // In a real-world scenario, you can fetch the version using platform channels or native Android code.
    // For now, we return 30, which is Android 11 (API 30).
    return 30; // Simulating Android 11
  }

  Future<void> _checkPermissionsAndImageExistence() async {
    // Request storage permission at runtime
    if (await _requestStoragePermission()) {
      print("Storage permissionn");
      _checkDownloaded(widget.message.message ?? "");
    } else {
      print("Storage permission denied");
    }
  }

  Future<void> _requestPermission() async {
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }
  }

  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid &&
        (Platform.version.startsWith('10') ||
            Platform.version.startsWith('11'))) {
      return await Permission.photos.request().isGranted;
    } else {
      // For devices below Android 10, we can use legacy storage permissions
      return await Permission.storage.request().isGranted;
    }
  }

  @override
  void initState() {
    _checkPermissionsAndImageExistence();
    super.initState();
  }

  Future<void> _checkDownloaded(String imageUrl) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      _localPath = directory.path;
      final filePath = '$_localPath/${imageUrl.split('/').last}';
      final file = File(filePath);

      // Check if file exists in local directory
      bool exists = await file.exists();

      print("File existence in local path: $exists");

      setState(() {
        _downloadStatus[imageUrl] = exists;
        _downloadloading[imageUrl] = false; // Loading should be false
      });
    } catch (e) {
      debugPrint("Error checking file existence: $e");
    }
  }

  Future<bool> _isImageInGallery(String imageUrl) async {
    try {
      if (!(await Permission.storage.request().isGranted)) {
        throw PlatformException(
            code: 'PERMISSION_DENIED',
            message: 'Storage permission not granted');
      }

      String picturesDirectory = await getPicturesDirectory(imageUrl);

      // Check if the image exists in the pictures directory
      String filePath = '$picturesDirectory/${imageUrl.split('/').last}';
      bool exists = await File(filePath).exists();

      return exists;
    } catch (e) {
      print('Error checking image existence: $e');
      return false;
    }
  }

  Future<String> getPicturesDirectory(String imageUrl) async {
    try {
      // Get the external storage directory
      Directory? externalDir = await getExternalStorageDirectory();
      if (externalDir == null) {
        throw Exception('External storage directory not found');
      }
      String name = " ${imageUrl.split('?').first.split('/').last}";
      // Navigate to the pictures directory (assuming it's named "Pictures")
      String picturesPath = '${externalDir.path}/$name';
      Directory picturesDir = Directory(picturesPath);
      if (!await picturesDir.exists()) {
        throw Exception('Pictures directory not found');
      }

      return picturesPath;
    } catch (e) {
      print('Error getting pictures directory: $e');
      rethrow; // Re-throw the error for handling in the caller
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMe = widget.message.isMe ?? false;

    return commonBuildMessageOuter(
        context: context,
        message: widget.message,
        isMe: isMe,
        isSameUser: widget.isSameUser,
        child: Container(
          width: 250.w,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(children: [
                  Image(
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SizedBox(
                          child: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white)),
                        );
                      },
                      // width: 200,
                      // height: 200,
                      fit: BoxFit.contain,
                      image: ResizeImage(
                        NetworkImage(
                          widget.message.message ?? "",
                        ),
                        width: 350,
                        height: 250,
                        allowUpscaling: true,
                      )),
                  if (widget.message.fileDownloadFlag == true)
                    Positioned(
                      top: 0, // Adjust as needed for padding
                      right: 8, // Adjust as needed for padding
                      child: GestureDetector(
                        onTap: () {
                          // Handle tap on AdminTableDotIcon
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: isMe ? Colors.white : Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: AdminTableDotIcon(
                              height: 30,
                              clr: Colors.transparent,
                              iconClr: Colors.black,
                              icons: Icons.expand_more,
                              iconSize: 20,
                              mouseHoverFunc: (val) {},
                              valueList: item,
                              onTap: (val) {
                                _downloadImage(widget.message.message ?? "");
                                // Handle popup menu item selection
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                      child: widget.message.fileDownloadFlag != true
                          ? BlurryContainer(
                              color: Colors.transparent,
                              height: 200.h,
                              width: 250.w,
                              child: SizedBox(
                                  height: 20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _downloadImage(
                                              widget.message.message ?? "");
                                        },
                                        child: _downloadloading[
                                                    widget.message.message] !=
                                                true
                                            ? const Card(
                                                color: Color.fromARGB(
                                                    147, 255, 255, 255),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.download,
                                                      size: 36,
                                                    ),
                                                    Text(
                                                      "download",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    )
                                                  ],
                                                ))
                                            : const CircularProgressIndicator(),
                                      ),
                                    ],
                                  )),
                            )
                          : SizedBox()),
                ]),
              ),

              //if content hase in image*******************************************************************
              // Linkify(
              //   linkStyle: GoogleFonts.poppins(decorationColor: Colors.blue),
              //   onOpen: (link) async {
              //     if (!await launchUrl(Uri.parse(link.url))) {
              //       throw Exception('Could not launch ${link.url}');
              //     }
              //   },
              //   text: widget.message.message ?? "",
              //   textAlign: TextAlign.left,
              //   style: chatTextstyle,
              // ),
              Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.message.time ?? "",
                      style: GoogleFonts.poppins(
                          color: Color(0xff666666),
                          fontWeight: FontWeight.w400,
                          fontSize: 11.sp),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    if (isMe)
                      _buildMessageStatus(
                          widget.message.messageStatus ?? "sent"),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

Widget _buildMessageStatus(String status) {
  if (status == MessageStatus.sent) {
    return Icon(
      Icons.check,
      color: Colors.grey,
      size: 13.sp,
    ); // Single tick
  } else if (status == MessageStatus.delivered) {
    return Icon(
      Icons.done_all,
      color: Colors.grey,
      size: 13.sp,
    ); // Double gray ticks
  } else if (status == MessageStatus.read) {
    return Icon(
      Icons.done_all,
      color: Colors.blue,
      size: 13.sp,
    ); // Double blue ticks
  } else {
    return SizedBox.shrink();
  }
}

Widget commonBuildMessageOuter(
    {required Widget child,
    required BuildContext context,
    required ChatMessage message,
    required bool isMe,
    required bool isSameUser}) {
  ChatScreenController controller = Get.put(ChatScreenController());
  return Padding(
    padding:
        EdgeInsets.symmetric(horizontal: message.isSelcted == true ? 5 : 0),
    child: Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMe &&
            controller.selectedMessage
                .any((e) => e.messageId == message.messageId))
          AppCheckBox(
            value: controller.selectedMessage
                .any((e) => e.messageId == message.messageId),
          ),
        const SizedBox(
          width: 5,
        ),
        if (!isSameUser && !isMe)
          GestureDetector(
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (_) =>
                      imageDialog(message.name, message.image, context));
            },
            child: Align(
                alignment: Alignment.topLeft,
                child: message.image == null || message.image?.isEmpty == true
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 13.r,
                        child: TextAvatar(
                          shape: Shape.Circular,
                          size: 14,
                          numberLetters: 2,
                          fontSize: 13.sp,
                          textColor: Colors.white,
                          fontWeight: FontWeight.bold,
                          text: "${message.name.toString().toTitleCase()}",
                        ))
                    : CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 18,
                        backgroundImage: NetworkImage(message.image ?? ""),
                      )),
          ),
        SizedBox(width: !isSameUser ? 5 : 35),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width - 300,
                  maxWidth: MediaQuery.of(context).size.width - 100,
                ),
                padding: const EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(
                    vertical: message.reaction != null &&
                            message.reaction?.isNotEmpty == true
                        ? 15
                        : isSameUser
                            ? 3
                            : 6,
                    horizontal: 10),
                decoration: BoxDecoration(
                  color: isMe ? AppColors.lightChat : AppColors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message.fwdFlag == true)
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_forward,
                              size: 16.sp,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            const Text("Forwarded",
                                style: TextStyle(
                                  color: AppColors.primary,
                                ))
                          ],
                        ),
                      SizedBox(
                        height: 5,
                      ),
                      IntrinsicWidth(child: child),
                    ],
                  ),
                )),
            Positioned(
              bottom: -4,
              right: isMe ? null : AppSpacings.xxSmall2,
              left: isMe ? AppSpacings.xxSmall2 : null,
              child: Text(
                message.reaction ?? "",
                style: const TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
        SizedBox(
          width: 5,
        ),
        if (isMe &&
            controller.selectedMessage
                .any((e) => e.messageId == message.messageId))
          AppCheckBox(
            value: controller.selectedMessage
                .any((e) => e.messageId == message.messageId),
          ),
        const SizedBox(
          width: 5,
        ),
      ],
    ),
  );
}
