import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:info91/src/widgets/custom/custom_circle_image.dart';


class ProfileTopImageSec extends StatelessWidget {
  final String backGroundImage;
  final String profileImage;
  final bool isAdmin;
  final Function? onProfileChange;
    final Function? onCoverChange;
  final bool isProfile;
  const ProfileTopImageSec(
      {super.key,
      required this.backGroundImage,
      required this.profileImage,
      this.isAdmin = false,
      this.isProfile = true, this.onProfileChange, this.onCoverChange});
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
        completer.complete();  // Successfully loaded
      },
      onError: (dynamic error, StackTrace? stackTrace) {
        completer.completeError(error);  // Failed to load
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
        final imageProvider = snapshot.data ?? const AssetImage("assets/images/empty_cover_pic.png");

        return Stack( 
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 180.h,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image:imageProvider,
                    fit: BoxFit.cover,),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 8.h),
                    child: InkWell(
                      onTap: () {
                        if(onCoverChange!=null){
                          onCoverChange!();
                        }
                        // pickFromCamera();
                      },
                      child: isAdmin ? 
                      roundCamera() : SizedBox(),
                    ),
                  )
                ],
              ),
            ),
            if (isProfile)
              Positioned(
                top: 152.h,
                left: 18.w,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: circle_image(profileImage, radius: 31),
                    ),
                    if (isAdmin)
                      InkWell(onTap: (){
                        if(onProfileChange!=null){
                        onProfileChange!();
                      }
                      },
                        child: roundCamera())
                  ],
                ),
              ),
          ],
        );
      }
    );
  }
}

class roundCamera extends StatelessWidget {
  const roundCamera({
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
