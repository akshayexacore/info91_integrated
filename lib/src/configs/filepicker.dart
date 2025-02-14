import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';

import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/informationgroup/chat_model.dart';
import 'package:info91/src/modules/information_groups/presentation/blocs/chat_screen_controller.dart';
import 'package:video_player/video_player.dart';

class FilePickerHelper {
  final picker = ImagePicker();
  late File _imageFile;
  FilePickerResult? result;

  Future<String> pickFiles(
      String filetype, BuildContext context, String? source,
      {Function(dynamic)? onDone, String? groupId}) async {
    switch (filetype) {
      case 'image':
        String data = await _handleImageSelection(context, source, onDone,
            groupId: groupId);
        return data;

      case 'MultipleFile':
        String file = await _handleMultipleFileSelection(context);
        return file;
        break;
      default:
        print('Unsupported file type');
    }
    return "";
  }

  bool _isVideo(File file) {
    final String filePath = file.path;
    return filePath.endsWith('.mp4') ||
        filePath.endsWith('.avi') ||
        filePath.endsWith('.mov');
  }

  Future<String> _handleImageSelection(
      BuildContext context, String? source, Function(dynamic)? onDone,
      {String? groupId}) async {
    XFile? pickedFile;
    if (source == 'camera') {
      pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      final FilePickerResult = await FilePicker.platform.pickFiles(
        type: FileType.media,
      );
      if (FilePickerResult != null) {
        pickedFile = XFile(FilePickerResult.files.single.path!);
      }
    }
    if (pickedFile == null) {
      return "";
    }
    File _imageFile = File(pickedFile.path);
    if (_isVideo(_imageFile)) {
      _showImagePreviewDialog(context, source, _imageFile, onDone,
          groupId: groupId);
    } else {
      var compressedImage = await compressFile(_imageFile);
      _imageFile = File(compressedImage.path);
      if (await _isFileSizeWithinLimit(
        compressedImage,
      )) {
        return compressedImage.path;
      } else {
        _showSizeExceedDialog(context);
        return "";
      }
    }
    return "";
  }

  Future<String> _handleMultipleFileSelection(BuildContext context) async {
    result = await FilePicker.platform
        .pickFiles(allowMultiple: false, allowCompression: true);

    if (result == null) {
      // User canceled the file picking
      return "";
    }

    for (PlatformFile file in result!.files) {
      if (_isFileSizeWithinLimitFromSize(file.size, maxSizeInMB: 5)) {
        return file.path ?? "";
        // Handle file upload
        print('File path: ${file.path}');
        print('File size: ${file.size}');
      } else {
        _showSizeExceedDialog(context);
      }
    }
    return "";
  }

  Future<XFile> compressFile(File file) async {
    final filePath = file.absolute.path;
    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 15,
    );
    print(file.lengthSync());
    print(result!.length());
    return result;
  }

  Future<bool> _isFileSizeWithinLimit(XFile results, {int sized = 1024}) async {
    final fileSizeInBytes = await results.length();
    final fileSizeInKB = fileSizeInBytes / sized;
    final fileSizeInMB = fileSizeInKB / sized;
    print('File size: $fileSizeInKB KB ($fileSizeInMB MB)');
    int maxSizeBytes = 10 * 1024 * 1024;
    print("File size: $maxSizeBytes");

    return fileSizeInMB <= maxSizeBytes;
  }

  bool _isFileSizeWithinLimitFromSize(int sizeInBytes,
      {required int maxSizeInMB}) {
    final fileSizeInMB = sizeInBytes / (1024 * 1024);
    return fileSizeInMB <= maxSizeInMB;
  }

  void _showImagePreviewDialog(BuildContext context, String? source,
      File imageFile, Function(dynamic)? onDone,
      {String? groupId}) {
    InputBorder? borderStyle() {
      return OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.transparent.withOpacity(.5)));
    }

    showModalBottomSheet(
      barrierColor: Color.fromARGB(255, 238, 230, 230),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Builder(builder: (context) {
          return Material(
            // This ensures the material context is available
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.only(
                bottom:
                    MediaQuery.of(context).viewInsets.bottom, // Add this line
              ),
              color: Colors.black,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 25.sp,
                            )),
                      ],
                    ),
                  ),
                  Center(
                    child: _isVideo(imageFile) // Check if it's a video
                        ? VideoPlayerWidget(file: imageFile)
                        : SizedBox(
                            height: MediaQuery.of(context).size.height / 1.6,
                            child: Center(
                                child: Image.file(
                              imageFile,
                              width: MediaQuery.of(context).size.width,
                              height: 500.h,
                              fit: BoxFit.fitHeight,
                            ))),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Padding(
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: marginWidth),
                      //   child: TextFormField(
                      //       decoration: InputDecoration(
                      //           fillColor: AppColors.white,
                      //           hintText: "Add a caption.....",
                      //           hintStyle: GoogleFonts.poppins(
                      //               color: AppColors.black,
                      //               fontWeight: FontWeight.w400),
                      //           filled: true,
                      //           contentPadding: const EdgeInsets.symmetric(
                      //               vertical: 10, horizontal: 4),
                      //           border: borderStyle(),
                      //           errorBorder: borderStyle(),
                      //           focusedBorder: borderStyle(),
                      //           enabledBorder: borderStyle(),
                      //           disabledBorder: borderStyle())),
                      // ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ListTile(
                          focusColor: Colors.red,
                          title: Text("Akshay",
                              style: GoogleFonts.poppins(
                                color: AppColors.white,
                              )),
                          trailing: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                ChatScreenController().fileUpload(
                                    imageFile.path, "video",
                                    groupId: groupId);
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.send),
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void _showSizeExceedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Media size exceeds the limit"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
              ],
            )
          ],
        );
      },
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final File file;

  const VideoPlayerWidget({Key? key, required this.file}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late String _formattedDuration;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        setState(() {});
        _controller.addListener(() {
          setState(() {
            _formattedDuration = _formatDuration(_controller.value.position);
          });
        });
      });

    // Initial formatted duration

    _formattedDuration = _formatDuration(Duration.zero);
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: marginWidth),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _controller.value.isInitialized
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 500.h,
                  child: VideoPlayer(_controller),
                )
              : CircularProgressIndicator(),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Text(
                _formattedDuration,
                style: TextStyle(color: AppColors.white),
              ),
              IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: AppColors.white,
                  size: 30.sp,
                ),
                onPressed: () {
                  print("tyes is prsse");
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
              ),
              Expanded(
                child: _controller.value.isInitialized
                    ? Slider(
                        value: _controller.value.position.inSeconds.toDouble(),
                        min: 0.0,
                        max: _controller.value.duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          _controller.seekTo(Duration(seconds: value.toInt()));
                        },
                      )
                    : Slider(
                        value: 0.0,
                        min: 0.0,
                        max: 1.0,
                        onChanged: (_) {},
                      ),
              ),
              Text(
                _formatDuration(_controller.value.duration),
                style: TextStyle(color: AppColors.white),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class NetworkVideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  NetworkVideoPlayerWidget({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  _NetworkVideoPlayerWidgetState createState() =>
      _NetworkVideoPlayerWidgetState();
}

class _NetworkVideoPlayerWidgetState extends State<NetworkVideoPlayerWidget> {
  late VideoPlayerController _controller;
  late String _formattedDuration;

  @override
  void initState() {
    super.initState();

    // Initialize the video controller with a network URL
    _controller = VideoPlayerController.network(
      widget.videoUrl,
    )..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.addListener(() {
          setState(() {
            _formattedDuration = _formatDuration(_controller.value.position);
          });
        });
      });

    // Initial formatted duration
    _formattedDuration = _formatDuration(Duration.zero);
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: _controller.value.isInitialized
                  ? VideoPlayer(_controller)
                  : const Center(
                      child: SizedBox(
                        height:
                            30, // Desired height for the CircularProgressIndicator
                        width:
                            30, // Desired width for the CircularProgressIndicator
                        child: const CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2, // Optional: make the stroke thinner
                        ),
                      ),
                    )),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                _formattedDuration,
                style: const TextStyle(color: Colors.white),
              ),
              IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  });
                },
              ),
              Expanded(
                child: _controller.value.isInitialized
                    ? Slider(
                        value: _controller.value.position.inSeconds.toDouble(),
                        min: 0.0,
                        max: _controller.value.duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          _controller.seekTo(Duration(seconds: value.toInt()));
                        },
                      )
                    : Slider(
                        value: 0.0,
                        min: 0.0,
                        max: 1.0,
                        onChanged: (_) {},
                      ),
              ),
              Text(
                _formatDuration(_controller.value.duration),
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ],
      ),
    );
  }
}

void showVideoPreviewDialog(BuildContext context,
    {required ChatMessage model}) {
  InputBorder? borderStyle() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColors.transparent.withOpacity(.5)));
  }

  showModalBottomSheet(
    barrierColor: Color.fromARGB(255, 238, 230, 230),
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Builder(builder: (context) {
        return Material(
          // This ensures the material context is available
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, // Add this line
            ),
            color: Colors.black,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20.sp,
                          )),
                      Text(model.isMe == true ? "You" : model.name ?? "",
                          style: TextStyle(
                            color: AppColors.white,
                          )),
                    ],
                  ),
                ),
                Center(
                    child: NetworkVideoPlayerWidget(
                  videoUrl: model.message ?? "",
                )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Padding(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: marginWidth),
                    //   child: TextFormField(
                    //       decoration: InputDecoration(
                    //           fillColor: AppColors.white,
                    //           hintText: "Add a caption.....",
                    //           hintStyle: GoogleFonts.poppins(
                    //               color: AppColors.black,
                    //               fontWeight: FontWeight.w400),
                    //           filled: true,
                    //           contentPadding: const EdgeInsets.symmetric(
                    //               vertical: 10, horizontal: 4),
                    //           border: borderStyle(),
                    //           errorBorder: borderStyle(),
                    //           focusedBorder: borderStyle(),
                    //           enabledBorder: borderStyle(),
                    //           disabledBorder: borderStyle())),
                    // ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
    },
  );
}
