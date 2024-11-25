import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:image_picker/image_picker.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/widgets/custom/custom_circle_image.dart';

class ProfileTopImageSec extends StatelessWidget {
  final String backGroundImage;
  final String profileImage;
  final bool isAdmin;
  final Function? onProfileChange;
  final Function? onCoverChange;
  final Function? profileViewOnTap;
  final bool isProfile;
  const ProfileTopImageSec(
      {super.key,
      required this.backGroundImage,
      required this.profileImage,
      this.isAdmin = false,
      this.profileViewOnTap,
      this.isProfile = true,
      this.onProfileChange,
      this.onCoverChange});
  void pickFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      //selectedFile(photo.path);
      // cropImage(photo.path);
    }
  }

  Future<ImageProvider> _loadImageProvider() async {
    final networkImage = NetworkImage(backGroundImage);
    final completer = Completer<void>();

    networkImage.resolve(const ImageConfiguration()).addListener(
          ImageStreamListener(
            (ImageInfo info, bool synchronousCall) {
              completer.complete(); // Successfully loaded
            },
            onError: (dynamic error, StackTrace? stackTrace) {
              completer.completeError(error); // Failed to load
            },
          ),
        );

    try {
      await completer.future;
      return networkImage;
    } catch (_) {
      return const AssetImage("assets/images/empty_cover_pic.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ImageProvider>(
        future: _loadImageProvider(),
        builder: (context, snapshot) {
          final imageProvider = snapshot.data ??
              const AssetImage("assets/images/empty_cover_pic.png");

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 180.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                   isAdmin ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 17.w, vertical: 8.h),
                      child: CustomRoundIcons(onProfileChange: (){
                        if (onCoverChange != null) {
                              onCoverChange!();
                            }
                      },),
                    ): SizedBox()
                  ],
                ),
              ),
              if (isProfile)
                Positioned(
                  top: 152.h,
                  left: 18.w,
                  child: Stack(
                    // clipBehavior: Clip.none,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: circle_image(
                            avatarUrl: profileImage,
                            radius: 31,
                            onTap: () { if (profileViewOnTap != null) {
                          profileViewOnTap!();
                        }}),
                      ),
                      if (isAdmin)
                       
                        InkWell(
                            onTap: () {
                              if (onProfileChange != null) {
                                onProfileChange!();
                              }
                            },
                            child:  CustomRoundIcons(onProfileChange: (){ if (onProfileChange != null) {
                                onProfileChange!();
                              }},))
                    ],
                  ),
                ),
            ],
          );
        });
  }
}

class CustomRoundIcons extends StatelessWidget {
  const CustomRoundIcons({
    super.key,
    required this.onProfileChange,
  });

  final Function? onProfileChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (onProfileChange != null) {
            onProfileChange!();
          }
        },
        child: const CircleAvatar(
          radius: 15,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.edit, color: AppColors.white, size: 17),
        ));
  }
}

class RoundIcons extends StatelessWidget {
  const RoundIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/roundcamera.png",
      height: 25,
    );
  }
}
