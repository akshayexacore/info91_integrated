import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

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
