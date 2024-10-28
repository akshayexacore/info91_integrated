import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/models/informationgroup/info-model.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/startscreen/start_controller.dart';
import 'package:info91/src/resources/infromation_repository.dart';

class GroupInfpController extends GetxController {
  final _infromationRepository = InfromationRepository();
  final startController = Get.put(StarScreenController());
  var dataModel = InfoGroupDataModel().obs;
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

  getInfoData() async {
    try {
      print(groupId ?? "");
      final response = await _infromationRepository.getInfoData(groupId);
      if (response != null) {
        dataModel.value = response;
        mobileNumberController.text =response.mobileNumber??"";
        alterNativeMobileNumberController.text= response.alternativeNumber??"";
        whatsappNumberController.text =response.whatsappNumber??"";
        contactTimeController.text = response.contactTime??"";
        holidaysController.text =response.holidays??"";
        websiteLinkController .text= response.websiteLink??"";
        youtubeLinkController.text= response.youtubeLink??"";
        googleMapControllerController.text = response.googlemapLink??"";
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }
}
