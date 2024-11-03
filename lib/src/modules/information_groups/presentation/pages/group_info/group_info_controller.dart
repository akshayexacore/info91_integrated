import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/models/informationgroup/info-model.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/startscreen/start_controller.dart';
import 'package:info91/src/resources/infromation_repository.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';

class GroupInfpController extends GetxController {
  final _infromationRepository = InfromationRepository();
  final startController = Get.put(StarScreenController());
  var dataModel = InfoGroupDataModel().obs;
  var isLoading = false.obs;
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController alterNativeMobileNumberController =
      TextEditingController();
  TextEditingController whatsappNumberController = TextEditingController();
  TextEditingController contactTimeController = TextEditingController();
  TextEditingController holidaysController = TextEditingController();
  TextEditingController websiteLinkController = TextEditingController();
  TextEditingController youtubeLinkController = TextEditingController();
  TextEditingController googleMapControllerController = TextEditingController();

  var groupId;
  @override
  void onInit() {
    groupId = Get.arguments["group_id"];
    ;
    getInfoData();
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> getInfoData() async {
    try {
      isLoading.value = true;
      final response = await _infromationRepository.getInfoData(groupId);
      print("response${response.isAdmin}");
      if (response != null) {
        dataModel.value = response;

        mobileNumberController.text = response.mobileNumber ?? "";
        alterNativeMobileNumberController.text =
            response.alternativeNumber ?? "";
        whatsappNumberController.text = response.whatsappNumber ?? "";
        contactTimeController.text = response.contactTime ?? "";
        holidaysController.text = response.holidays ?? "";
        websiteLinkController.text = response.websiteLink ?? "";
        youtubeLinkController.text = response.youtubeLink ?? "";
        googleMapControllerController.text = response.googlemapLink ?? "";


        isLoading.value = false;

      }
    } catch (e) {
      isLoading.value = false;
      print("Error fetching data: $e");
    }
  }

  Future<void> updateInfoData() async {
   try {final response = await _infromationRepository.updateInfoData(
        model: InfoGroupDataModel(
            id: groupId,
            mobileNumber: mobileNumberController.text.trim(),
            alternativeNumber: alterNativeMobileNumberController.text.trim(),
            whatsappNumber: whatsappNumberController.text.trim(),
            contactTime: contactTimeController.text.trim(),
            holidays: holidaysController.text.trim(),
            websiteLink: websiteLinkController.text.trim(),
            youtubeLink: youtubeLinkController.text.trim(),
            googlemapLink: googleMapControllerController.text.trim()));
            if(response.data1){
            AppDialog.showSnackBar('Success',
              response.data2);
            }else{
               AppDialog.showSnackBar('Error',
              response.data2);
            }}catch(e){
              print("the erro r is $e");
            }
  }
}
