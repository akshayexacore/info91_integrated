import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:info91/src/configs/filepicker.dart';
import 'package:info91/src/models/informationgroup/group_profile.dart';
import 'package:info91/src/modules/information_groups/presentation/profile_section/controller/profile_controller.dart';
import 'package:info91/src/resources/infromation_repository.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';

class BannerController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  FilePickerHelper filePickerHelper = FilePickerHelper();
  final _bannerController = Get.find<InfoProfileController>();
  String groupId = "";
  var imagePath = ''.obs;
  var filePath = ''.obs;
  var isEdit = false.obs;
  var isBusy = false.obs;
  BannerModel data = BannerModel();
  final _infromationRepository = InfromationRepository();
  final ImagePicker _picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      cropImage(pickedFile.path);
      if (imagePath.isNotEmpty) {
        imagePath.value = "";
      }
    } else {
      Get.snackbar("Error", "No image selected");
    }
  }

  void cropImage(String image) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 80,
        cropStyle: CropStyle.rectangle,
        uiSettings: [
          AndroidUiSettings(
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            aspectRatioLockEnabled: true,
          )
        ]);
    if (croppedFile != null) {
      filePath(croppedFile.path);
    }
  }

  bool checkImageExist() {
    debugPrint(" Get.arguments['fasss']${imagePath.value}");
    return imagePath.value.isNotEmpty || filePath.value.isNotEmpty;
  }

  clearImage() {
    filePath.value = "";
    imagePath.value = "";
  }

  void resetFields() {
    titleController.clear();
    descriptionController.clear();
    imagePath.value = '';
  }

  @override
  void onInit() {
    resetFields();
    if (Get.arguments != null) {
      isEdit.value = Get.arguments['isUpdate'] ?? false;
      groupId = Get.arguments['group_id'] ?? '';
      if (isEdit.value == true && Get.arguments['model'] != null) {
        data = Get.arguments['model'];
        imagePath.value = data.image ?? "";
        titleController.text = data.title ?? "";
        descriptionController.text = data.description ?? "";
      }
    } else {
      debugPrint('No group data found in Get.arguments');
    }

    super.onInit();
  }

  @override
  void onClose() {
    resetFields();
    super.onClose();
  }

  Future<void> createBanner() async {
    if (!isBusy.value) {
      if (filePath.value.isNotEmpty) {
        if (formKey.currentState!.validate()) {
          isBusy.value = true;
          final response = await _infromationRepository.createBanner(
            file: filePath.value,
            groupId: groupId,
            title: titleController.text.trim(),
            description: descriptionController.text.trim(),
          );
          if (response.data1) {
            Get.back();
            AppDialog.showToast('Banner created successfully',
                isSucess: response.data1);

            isBusy.value = false;
          } else {
            isBusy.value = false;
            AppDialog.showToast(response.data2, isSucess: response.data1);
          }
        }
      } else {
        AppDialog.showSnackBar('Failed ', "Please select an image");
      }
    }
  }

  Future<void> deleteBanner() async {
    try {
      final response = await _infromationRepository.deleteBanner(
        groupId: groupId,
        bannerId: data.id ?? "",
      );

      if (response.data1) {
        Get.back();
        // AppDialog.showSnackBar('Success', "Banner removed successfully");
        // Future.delayed(Duration(milliseconds: 500), () {

        // });
      } else {
        AppDialog.showSnackBar('Failed ', response.data2);
      }
    } catch (e) {
      AppDialog.showSnackBar('Error', "An error occurred");
    }
  }

  Future<void> upDateBanner() async {
    if (!isBusy.value) {
      if (formKey.currentState!.validate()) {
        isBusy.value = true;
        final response = await _infromationRepository.upDateBanner(
          file: filePath.value,
          groupId: groupId,
          bannerId: data.id ?? "",
          title: titleController.text.trim(),
          description: descriptionController.text.trim(),
        );
        if (response.data1) {
          Get.snackbar('Success ', "Banner created successfully");

          isBusy.value = false;
        } else {
          isBusy.value = false;
        }
      }
    }
  }

  void showDeleteConfirmationDialog() {
    Get.defaultDialog(
      title: "Delete Confirmation",
      middleText: "Are you sure you want to delete this item?",
      textCancel: "Cancel",
      textConfirm: "Delete",
      confirmTextColor: Colors.white,
      onCancel: () {
        // Action for cancel button
        // Get.back();
      },
      onConfirm: () async {
        // Action for delete confirmation
        await deleteBanner(); // Call the delete function here
        Get.back(); // Call your delete function here
        // Get.back(); // Close the dialog after deleting
      },
      barrierDismissible:
          false, // Prevents dismissing the dialog by tapping outside
    );
  }
}
