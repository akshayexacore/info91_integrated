import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/informationgroup/group_profile.dart';
import 'package:info91/src/resources/infromation_repository.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';
import 'package:info91/src/widgets/custom/image_view.dart';

class InfoProfileController extends GetxController {
  var profilledataModel = GroupProfileModel().obs;
  var isLoading = false.obs;
  String groupId = "";
  final _infromationRepository = InfromationRepository();

  var selectedFile = ''.obs;

  Future<void> uploadFile() async {
    final response =
        await _infromationRepository.uploadFile(selectedFile.value, groupId);
    debugPrint("response.data1${response.data1}${response.data2}");
    if (response.data1) {
      profilledataModel.value = response.data2;
    } else {
      AppDialog.showSnackBar('Failed ', response.data2);
    }
  }

  Future<void> uploadCoverPic() async {
    final response = await _infromationRepository.uploadCoverPic(
        selectedFile.value, groupId);
    debugPrint("response.data1${response.data1}${response.data2}");
    if (response.data1) {
      profilledataModel.value = response.data2;
    } else {
      AppDialog.showSnackBar('Failed ', response.data2);
    }
  }

  Future<void> getGroupInfoDetails(String id) async {
    debugPrint("getGroupInfoDetails calling");
    try {
      isLoading.value = true;
      final response = await _infromationRepository.getProfileData(id ?? "");
      debugPrint("getGroupInfoDetails calling${response.memberCount}");
      profilledataModel.value = response;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      throw e;
    }
  }

  void pickFromCamera({bool isCrop = true}) async {
    Get.back();
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      if (isCrop) {
        cropImage(photo.path);
      } else {
        selectedFile(photo.path);
      }
    }
  }

  void pickFromGallery({bool isCrop = true}) async {
    debugPrint("isCrop$isCrop");
    Get.back();
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);

    if (photo != null) {
      if (isCrop) {
        cropImage(photo.path);
      } else {
        debugPrint("isCrop${photo?.path??""}");
        selectedFile(photo.path);
        uploadCoverPic();
      }
    }
  }

  void cropImage(String image) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 80,
        cropStyle: CropStyle.circle,
        uiSettings: [
          AndroidUiSettings(
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            aspectRatioLockEnabled: true,
          )
        ]);
    if (croppedFile != null) {
      selectedFile(croppedFile.path);
      uploadFile();
    }
  }

  void clearImage() async {
    Get.back();
    AppDialog.showDialog(
        title: "Remove",
        content: "Are you sure you want to remove Profile Picture?",
        secondaryText: "Cancel",
        onSecondaryPressed: Get.back,
        dismissible: true,
        primaryText: "Remove",
        onPrimaryPressed: () {
          // selectedFile('');
          Get.back();
        });
  }

  void showUploadOptions({bool isCrop = true}) {
    debugPrint("isCrop$isCrop");
    Get.bottomSheet(
        DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 1, width: MediaQuery.sizeOf(context).width),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pickFromCamera(isCrop: isCrop);
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius:
                                      MediaQuery.sizeOf(context).width * 0.1,
                                  backgroundColor: AppColors.secondary,
                                  child: const AppAssetImage(
                                    "assets/images/ic_camera.png",
                                    height: 24,
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "Camera",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            pickFromGallery(isCrop: isCrop);
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius:
                                      MediaQuery.sizeOf(context).width * 0.1,
                                  backgroundColor: AppColors.secondary,
                                  child: const AppAssetImage(
                                    "assets/images/ic_gallery.png",
                                    height: 24,
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "Gallery",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: clearImage,
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius:
                                      MediaQuery.sizeOf(context).width * 0.1,
                                  backgroundColor: AppColors.secondary,
                                  child: const AppAssetImage(
                                    "assets/images/ic_delete.png",
                                    height: 24,
                                  )),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "Delete",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            expand: false,
            maxChildSize: 1,
            initialChildSize: 0.4),
        backgroundColor: AppColors.white);
  }
}