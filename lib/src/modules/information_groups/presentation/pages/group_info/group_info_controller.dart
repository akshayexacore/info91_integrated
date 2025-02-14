import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/models/informationgroup/chat_model.dart';
import 'package:info91/src/models/informationgroup/info-model.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/startscreen/start_controller.dart';
import 'package:info91/src/resources/infromation_repository.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class GroupInfpController extends GetxController {
  final _infromationRepository = InfromationRepository();
  final startController = Get.put(StarScreenController());
  var dataModel = InfoGroupDataModel().obs;
  var isLoading = false.obs;
  var isNonEdit = false.obs;
  var isNameValid = true.obs; //
  var errorMessage = ''.obs;
   final formkey = GlobalKey<FormState>();
  var key1Controller = TextEditingController().obs;
  var key2Controller = TextEditingController().obs;
  var key3Controller = TextEditingController().obs;
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController alterNativeMobileNumberController =
      TextEditingController();
  TextEditingController whatsappNumberController = TextEditingController();
  TextEditingController contactTimeController = TextEditingController();
  TextEditingController holidaysController = TextEditingController();
  TextEditingController websiteLinkController = TextEditingController();
  TextEditingController youtubeLinkController = TextEditingController();
  TextEditingController googleMapControllerController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController adddressController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  var groupId;
  @override
  void onInit() {
    if (Get.arguments != null) {
      groupId = Get.arguments["group_id"];
      isNonEdit.value = Get.arguments["non_edit"] ?? false;
    }

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
        key1Controller.value.text = response.tagKey1 ?? "";
        key2Controller.value.text = response.tagKey2 ?? "";
        key3Controller.value.text = response.tagKey3 ?? "";
        aboutController.text = response.purpose ?? "";
         adddressController.text=response.address ?? "";
         emailController.text=response.email ?? "";
         typeController.text=response.type ?? "";
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      print("Error fetching data: $e");
    }
  }

  void saveContact(String contact) async {
    final String url = 'tel:$contact';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> updateInfoData() async {
    try {
      bool isFormValid = formkey.currentState!.validate();
      if(isFormValid){
         if (isNameValid.value) {
        final response = await _infromationRepository.updateInfoData(
            model: InfoGroupDataModel(
                id: groupId,
                mobileNumber: mobileNumberController.text.trim(),
                alternativeNumber:
                    alterNativeMobileNumberController.text.trim(),
                whatsappNumber: whatsappNumberController.text.trim(),
                contactTime: contactTimeController.text.trim(),
                holidays: holidaysController.text.trim(),
                tagKey1: key1Controller.value.text.trim(),
                tagKey2: key2Controller.value.text.trim(),
                tagKey3: key3Controller.value.text.trim(),
                websiteLink: websiteLinkController.text.trim(),
                youtubeLink: youtubeLinkController.text.trim(),
                purpose: aboutController.text.trim(),
                address: adddressController.text.trim(),
                email: emailController.text.trim(),
                googlemapLink: googleMapControllerController.text.trim()));
        if (response.data1) {
          AppDialog.showSnackBar('Success', response.data2);
        } else {
          AppDialog.showSnackBar('Error', response.data2);
        }
      } else {
        AppDialog.showSnackBar('Error', "Key one value is already exist");
      }
      }
     
    } catch (e) {
      print("the erro r is $e");
    }
  }

  Future<void> launchURL(String urls) async {
    final Uri url = Uri.parse(urls);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      AppDialog.showSnackBar("Error", "Invalid Url");
    }
  }

  Future<void> keyCheckExistFunction(
    String key,
  ) async {
    try {
      final response = await _infromationRepository.keyCheckExistFunction(key);
      if (response.data1) {
        isNameValid.value = true;
        errorMessage.value = "";
      } else {
        isNameValid.value = false;
        errorMessage.value = response.data2;
      }
    } catch (e) {
      print("the error is here$e");
    }
  }
}
