import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/configs/variables.dart';
import 'package:info91/src/models/user.dart';
import 'package:info91/src/modules/auth/login/login_page.dart';
import 'package:info91/src/modules/landing/landing_page.dart';
import 'package:info91/src/resources/auth_repository.dart';
import 'package:info91/src/resources/shared_preferences_data_provider.dart';
import 'package:info91/src/resources/user_profile_repository.dart';
import 'package:info91/src/utils/app_validator.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  late var busy = false.obs;
  late var isError = false.obs;
  late var isNameValid = false.obs;

  late final textControllerName = TextEditingController();
  late final textControllerAbout = TextEditingController();
  late final textControllerPincode = TextEditingController();
    late final mobileController = TextEditingController();
  late final _userProfileRepository = UserProfileRepository();
  late final _authRepository = AuthRepository();
  var errorMessage = ''.obs;
  var user = Rxn<User>();
var isEdit=false.obs;
  late ProgressDialog pr;
  var progress = 0.obs;
  var selectedFile = ''.obs;

  @override
  void onInit() {
    pr = ProgressDialog(Get.context!, isDismissible: false);

    getUser();
       if (Get.arguments != null) {
      isEdit.value = Get.arguments['isUpdate'] ?? false;
    
      
    } else {
      debugPrint('No group data found in Get.arguments');
    }
    getPhonenUmber();
    super.onInit();
  }
 Future<void> getPhonenUmber()async {
  SharedPreferencesDataProvider model=SharedPreferencesDataProvider();
 mobileController.text=await model.getUserMobile();
 }
 Future<void> logoutFunction()async {
 final SharedPreferences sharedPreferences =await SharedPreferences.getInstance();

sharedPreferences.clear();
gotoLoginPage();
 }
  void gotoLoginPage() {
    Get.offAllNamed(LoginPage.routeName);
  }
  Future<void >getUser() async {
    try {
      busy(true);
      final response = await _userProfileRepository.getUser();
      debugPrint(
          'Updating user observable with image: ${response.user?.image}');
      if (response.success) {
        user(response.user);
        Variables.user=response.user;
        textControllerName.text = user.value?.name ?? '';
        textControllerAbout.text = user.value?.about ?? '';
        textControllerPincode.text = user.value?.pincode ?? "";

        selectedFile(response.user?.image);
      }
    } catch (_) {
      AppDialog.showToast(_.toString());
    } finally {
      busy(false);
    }
  }

  void logout() {
    AppDialog.showDialog(
        title: "LOGOUT",
        content: "Are you sure you want to logout?",
        secondaryText: "Cancel",
        onSecondaryPressed: Get.back,
        dismissible: true,
        primaryText: "Logout",
        onPrimaryPressed: _logout);
  }

  _logout() {
    _authRepository.logoutUser();
    Get.offAllNamed(LoginPage.routeName);
  }

  pinTextfieldOnchage(String value) {
    if (value.length == 6) {
      validatePincode();
    } else {
      if (errorMessage.isNotEmpty) {
        isError.value = false;
        errorMessage.value = "";
      }
    }
  }

  void updateProfile() async {
    try {
      busy(true);
      if (!validate()) {
        return;
      }
      if (isError.value) {
        AppDialog.showSnackBar('Failed ', "Invalid pincode");
        return;
      }
      if (textControllerPincode.text.length != 6) {
        AppDialog.showSnackBar('Failed ', "Invalid pincode");
        return;
      }
      await pr.show();
      pr.update(message: "Updating profile...");
      final response = await _userProfileRepository.updateUser(
          textControllerName.text.trim(),
          textControllerAbout.text.trim(),
          textControllerPincode.text.trim(),
          selectedFile.value.isURL ? '' : selectedFile.value,
          onProgress);
      pr.hide();
      if (response.isSuccess) {
       await getUser();
        AppDialog.showDialog(
            title: 'Success ',
            content: response.message,
            primaryText: "Ok",
            onPrimaryPressed: () {
              Get.offAllNamed(LandingPage.routeName);
            });
      } else {
        AppDialog.showSnackBar('Failed ', response.message);
      }
    } catch (_) {
      pr.hide();
      if (_ is DioError) {
        AppDialog.showSnackBar(
            'Failed ', _.response?.data['message'] ?? 'Bill uploading failed');
      }
    } finally {
      busy(false);
      pr.hide();
    }
  }

  void validatePincode() async {
    try {
      busy(true);
      pr.update(message: "Updating profile...");
      final response = await _userProfileRepository.validatePincode(
        textControllerPincode.text.trim(),
      );

      if (response?.statusCode == 200) {
        if (response.data != null) {
          errorMessage.value = response.data![0].postname ?? "";
          isError.value = false;
        }
      } else {
        errorMessage.value = response.message ?? "";
        isError.value = true;
      }
    } catch (_) {
      pr.hide();
      if (_ is DioError) {
        errorMessage.value = "Something wrong";
        isError.value = true;
      }
    } finally {
      busy(false);
      pr.hide();
    }
  }

  bool validate() {
    if (textControllerName.text.trim().isEmpty ||
        !AppValidator.isValidName(textControllerName.text)) {
      AppDialog.showSnackBar("Error", "Enter valid name");
      return false;
    }
    /*if(textControllerAbout.text.trim().isEmpty){
      AppDialog.showSnackBar("Error","Enter about yourself");
      return false;
    }
    if(selectedFile.isEmpty || extension(selectedFile.value).isEmpty){
      AppDialog.showSnackBar("Error","Please select a profile picture.");
      return false;
    }*/
    return true;
  }

  void pickFromCamera() async {
    Get.back();
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      //selectedFile(photo.path);
      cropImage(photo.path);
    }
  }

  void pickFromGallery() async {
    Get.back();
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      //selectedFile(photo.path);
      cropImage(photo.path);
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
          selectedFile('');
          Get.back();
        });
  }

  void showUploadOptions() {
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
                          onTap: pickFromCamera,
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
                          onTap: pickFromGallery,
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

  void onProgress(int value) {
    progress(value);
  }

   
}

