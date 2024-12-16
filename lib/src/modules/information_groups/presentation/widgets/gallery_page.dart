import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:just_audio/just_audio.dart';

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    this.headingText,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<GalleryItem> galleryItems;
  final Axis scrollDirection;
  final String? headingText;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SafeArea(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        children: [
                          Text(widget.headingText ?? ""),
                          Spacer(),
                          IconButton(
                            onPressed: Get.back,
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            style: IconButton.styleFrom(
                                backgroundColor: Colors.black),
                            highlightColor: AppColors.primary,
                          ),
                        ],
                      ))),
            )
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final GalleryItem item = widget.galleryItems[index];
    if (item.isAudio) {
      return PhotoViewGalleryPageOptions.customChild(
        child: AudioPlayerWidget(audioUrl: item.resource),
        initialScale: PhotoViewComputedScale.contained,
        minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
        maxScale: PhotoViewComputedScale.covered * 4.1,
        heroAttributes: PhotoViewHeroAttributes(tag: item.id),
      );
    } else if (item.isFile) {
      return PhotoViewGalleryPageOptions(
        imageProvider: FileImage(File(item.resource)),
        initialScale: PhotoViewComputedScale.contained,
        minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
        maxScale: PhotoViewComputedScale.covered * 4.1,
        heroAttributes: PhotoViewHeroAttributes(tag: item.id),
      );
    } else {
      return PhotoViewGalleryPageOptions(
        imageProvider: CachedNetworkImageProvider(item.resource),
        initialScale: PhotoViewComputedScale.contained,
        minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
        maxScale: PhotoViewComputedScale.covered * 4.1,
        heroAttributes: PhotoViewHeroAttributes(tag: item.id),
      );
    }
  }
}

class GalleryItem {
  GalleryItem({
    required this.id,
    required this.resource,
    this.isFile = false,
    this.isAudio = false,
  });

  final String id;
  final String resource;
  final bool isFile;
  final bool isAudio;
}

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerWidget({Key? key, required this.audioUrl}) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  late Duration _duration = Duration.zero;
  late Duration _position = Duration.zero; // Initialize _position
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setUrl(widget.audioUrl).then((duration) {
      setState(() {
        _duration = duration!;
      });
    });
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _position = position;
      });
    }); // Listen to when the audio finishes playing
    _audioPlayer.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
          _position = Duration.zero;
            _audioPlayer.stop();
        });
        _audioPlayer.seek(Duration.zero);
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        SizedBox(
         
          height: MediaQuery.of(context).size.height/1.2,
          child: Center(child: Icon(Icons.headphones,size: 120.sp,color: Colors.white,))),
          Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: AppColors.white,size: 25.sp,
                ),
                onPressed: _playPause,
              ),
              Expanded(
                child: Slider(
                  value: _position.inSeconds.toDouble(),activeColor: AppColors.primary,
                  max: _duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    _audioPlayer.seek(Duration(seconds: value.toInt()));
                    setState(() {});
                  },
                ),
              ),
              Text(
                  '${_position.inMinutes}:${(_position.inSeconds % 60).toString().padLeft(2, '0')}',style:const TextStyle(color: AppColors.white),),
              Text(
                  '/ ${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}',style:const TextStyle(color: AppColors.white),),
            ],
          ),
        ),
        SizedBox(height: 20.sp,)
      ],
    );
  }
}
