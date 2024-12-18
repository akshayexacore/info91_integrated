import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/configs/filepicker.dart';

import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoPlayerScreen2 extends StatefulWidget {
  final bool looping;
  final bool autoplay;
  final bool me;
  final String videoUrl;
  final AlignmentGeometry alignmentGeometry;

  VideoPlayerScreen2({
    Key? key,
    required this.looping,
    required this.me,
    required this.autoplay,
    required this.videoUrl,
    required this.alignmentGeometry,
  }) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen2> {
  ChewieController? _chewieController;
  VideoPlayerController? videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = videoPlayerController!.initialize();

    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      aspectRatio: 4 / 5,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            constraints: BoxConstraints(
              maxWidth: 275,
              maxHeight: MediaQuery.of(context).size.height / 2.5,
            ),
            key: PageStorageKey(widget.videoUrl),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Chewie(
                key: PageStorageKey(widget.videoUrl),
                controller: _chewieController!,
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }
}


class VideoMessageBubble extends StatefulWidget {
  final String videoPath;
  final String timestamp;
  final String videoDuration;
  final bool isSender;
  final String videoSize;
  final VoidCallback onTap;
  final double width;
  final double height;

  const VideoMessageBubble({
    Key? key,
    required this.videoPath,
    this.width=250,
    this.height=300,
    required this.timestamp,
    required this.videoDuration,
     required this.onTap,
    required this.isSender,required this.videoSize,
  }) : super(key: key);

  @override
  State<VideoMessageBubble> createState() => _VideoMessageBubbleState();
}

class _VideoMessageBubbleState extends State<VideoMessageBubble> {
  String? thumbnailPath;

  Future<void> generateThumbnail() async {
    try {
      final path = await VideoThumbnail.thumbnailFile(
        video:widget. videoPath, // Replace with a valid URL
        imageFormat: ImageFormat.PNG,
        maxWidth:widget. width.toInt(),
        quality: 75,
      );
      setState(() {
        thumbnailPath = path;
      });
    } catch (e) {
      print("Error generating thumbnail: $e");
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
 @override
  void initState() {
    super.initState();
    generateThumbnail();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(width: widget.width.w,
      height:  widget.height.h,
        // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        
        child: Stack(
                alignment: Alignment.center,
          children: [
            ClipRRect(
               borderRadius: BorderRadius.circular(12),
              child: thumbnailPath != null
                  ? Image.file(File(thumbnailPath!), width: 300,fit: BoxFit.fitWidth, )
                  : const CircularProgressIndicator(),
            ),const Icon(
                    Icons.play_circle_fill,
                    color: Colors.white,
                    size: 50,
                  ),
                   Positioned(
                   bottom: 5,
              left: 5,
              right: 5,
                    
            
              child: Row(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                   Icon(
                      Icons.videocam,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                const    SizedBox(width: 2,),
                    Text(
                    widget.videoSize ?? "",
                    style: GoogleFonts.poppins(
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 11.sp),
                  ),
                  ],),
                  Text(
                    widget.timestamp ?? "",
                    style: GoogleFonts.poppins(
                        color: AppColors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 11.sp),
                  ),
                  
                  // if (isMe) _buildMessageStatus(message.messageStatus ?? ""),
                ],
              ),
            ),
                  
          ],
        ),
      ),
    );
  }
}
