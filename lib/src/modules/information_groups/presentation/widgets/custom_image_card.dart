import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/configs/filepicker.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/VideoPlayerScreen2.dart';

class CustomImageCard extends StatelessWidget {
  final double? height;
  final double? width;
  final String imageUrl;
  final int? index;
  final int imageCount;
  final Function? onImageTap;
   final Function? onPicTap;
  final bool isVideo;
  const CustomImageCard({
    super.key,
    this.height,
    this.width,
    this.index,
    this.isVideo = false,
    required this.imageUrl,
    this.imageCount = 0,
    this.onPicTap,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
    ClipRRect( borderRadius: BorderRadius.circular(12.r), 
          child: Stack(
            children: [
              InkWell(
                onTap: (){
                  if(onPicTap!=null){
                    onPicTap!();
                  }
                },
                child: SizedBox(
                  height: height ?? 107.h,
                  width: width ?? 170.w,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              if (isVideo) ...[
                Center(
                    child: IconButton(
                  icon:const Icon(Icons.play_circle_outline_rounded),
                  color: AppColors.white,
                  onPressed: () {
                    if (onImageTap != null) {
                      onImageTap!();
                    }
                  },
                ))
              ]
            ],
          ),
        ),
        if (index == 2 && imageCount > 2)
          InkWell(
            onTap: () {
              if (onImageTap != null) {
                onImageTap!();
              }
            },
            child: Container(
              height: height ?? 100.h,
              width: width ?? 170.w,
              color: Color.fromARGB(121, 0, 0, 0),
              child: Center(
                child: Text(
                  "${(imageCount - 3).toString()}+",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp),
                ),
              ), // Black transparent overlay
            ),
          ),
      ],
    );
  }
}
class CustomMediaAudioCard extends StatelessWidget {
  final double? height;
  final double? width;
  final String imageUrl;
  final int? index;
  final String duration;
  final int imageCount;
  final Function? onImageTap;
   final Function? onPicTap;

  const CustomMediaAudioCard({
    super.key,
    this.height,
    this.width,
    this.index,
  required this.duration,
  
    required this.imageUrl,
    this.imageCount = 0,
    this.onPicTap,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect( borderRadius: BorderRadius.circular(12.r), 
      child: Stack(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: (){
                  if(onPicTap!=null){
                    onPicTap!();
                  }
                },
                child: Container(
                  color: AppColors.secondary,
                  height: height ?? 107.h,
                  width: width ?? 170.w,
                  child: 
                  Icon(
                    Icons.headphones,
                    size: 35.sp,
                    color: AppColors.white,
                    
                 
                  ),
                ),
              ),
        Positioned(bottom: 4,right: 3, child:    Text(duration,style: TextStyle(color: Colors.white),))
            ],
          ),
          if (index == 2 && imageCount > 2)
            InkWell(
              onTap: () {
                if (onImageTap != null) {
                  onImageTap!();
                }
              },
              child: Container(
                height: height ?? 100.h,
                width: width ?? 170.w,
              color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Text(
                    "${(imageCount - 3).toString()}+",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp),
                  ),
                ), // Black transparent overlay
              ),
            ),
        ],
      ),
    );
  }
}
class CustomMediaVideoCard extends StatelessWidget {
  final double? height;
  final double? width;
  final String videoUrl;
  final int? index;
  final String duration;
  final int imageCount;
  final Function? onImageTap;
   final Function? onPicTap;

  const CustomMediaVideoCard({
    super.key,
    this.height,
    this.width,
    this.index,
  required this.duration,
  
    required this.videoUrl,
    this.imageCount = 0,
    this.onPicTap,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            InkWell(
              onTap: (){
                if(onPicTap!=null){
                  onPicTap!();
                }
              },
              child:  VideoMessageBubble(
            isSender: false,
            videoDuration: "",
           height: height ?? 100.h,
              width: width ?? 170.w,
            videoPath: videoUrl?? "", videoSize:  "",
            timestamp: "",
            onTap: () {
                 if(onPicTap!=null){
                  onPicTap!();
                }
            },
            // videoPlayerController:
            //     VideoPlayerController.network(
            //   messageList[index].message ?? "",
            // ),
          ),
            ),
      // Positioned(bottom: 0,right: 0, child:    Container(
      //   width: width,
      //   color: AppColors.black.withOpacity(.3),
      //   child: Row(
      //     children: [
      //    const  Padding(
      //        padding:  EdgeInsets.only(left: 2.0),
      //        child:  Icon(Icons.videocam,color: AppColors.white,),
      //      ),
      //     const Spacer(), 
      //     Text(duration,style:const TextStyle(color: Colors.white),)
      //     ],
      //   ),
      // ))
          ],
        ),
        if (index == 2 && imageCount > 2)
          InkWell(
            onTap: () {
              if (onImageTap != null) {
                onImageTap!();
              }
            },
            child: Container(
              height: height ?? 100.h,
              width: width ?? 170.w,
            color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Text(
                  "${(imageCount - 3).toString()}+",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp),
                ),
              ), // Black transparent overlay
            ),
          ),
      ],
    );
  }
}
