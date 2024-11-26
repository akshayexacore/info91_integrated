import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/resources/infromation_repository.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';
import 'package:loader_overlay/loader_overlay.dart';

class GroupProfileEditionController extends GetxController {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  final _infromationRepository = InfromationRepository();
  final GlobalKey<FormState> formKey = GlobalKey();
  var groupId = "";

  @override
  void onInit() {
    if (Get.arguments != null) {
      groupId = Get.arguments["group_id"];
      groupNameController.text= Get.arguments["name"]??"";
      aboutController.text= Get.arguments["about"]??"";
    }
    super.onInit();
  }

  @override
  void dispose() {
    groupNameController..dispose();
    aboutController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> editGroupNameAndAbout() async {
    try {
      Get.context!.loaderOverlay.show();
      final response = await _infromationRepository.editGroupNameAndAbout(
          groupid: groupId,
          name: groupNameController.text.trim(),
          about: aboutController.text.trim());
      if (response.data1) {
        Get.back();
        AppDialog.showToast(
          response.data2,
        );
      }
    } catch (e) {
      AppDialog.showToast(
        "Something went wrong! Try again.",
      );
    } finally {
      Get.context!.loaderOverlay.hide();
    }
  }
}
