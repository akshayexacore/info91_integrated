import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:info91/src/models/informationgroup/group_profile.dart';
import 'package:info91/src/models/informationgroup/information_group.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/chat_screen/info_group_chat_screen.dart';
import 'package:info91/src/resources/infromation_repository.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class StarScreenController extends GetxController {
  late InfoGroupChatListModel? selectedChatModel;
  var responseModel = GroupProfileModel().obs;
  final _infromationRepository = InfromationRepository();
  @override
  void onInit() {
    if (Get.arguments != null &&
        Get.arguments['group'] is InfoGroupChatListModel) {
      selectedChatModel = Get.arguments['group'] as InfoGroupChatListModel;
      debugPrint('selectedChatModel: ${selectedChatModel?.groupName}');
    } else {
      debugPrint('No group data found in Get.arguments');
    }
    getGroupInfoDetails();
    super.onInit();
  }

  Future<void> joinMessageTapFunc() async {
    try {
      if(selectedChatModel?.joinedGroupFlag==true ){ Get.to(ChatScreen(
          selectedGroupId: selectedChatModel?.id,
          model: responseModel.value,
        ));}else{
            final response = await _infromationRepository
          .joinMessageTapFunc(selectedChatModel?.id ?? "");
      if (response.data1) {
        AppDialog.showSnackBar('Suceess', '${response.data2}');
        Get.to(ChatScreen(
          selectedGroupId: selectedChatModel?.id,
          model: responseModel.value,
        ));
      } else {
        AppDialog.showSnackBar('Failure', '${response.data2}');
      }
        }
    
    } catch (e) {
      throw e;
    }
  }
Future<void> launchURL(String urls) async {
    final Uri url = Uri.parse(urls);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication); 
    } else {
      throw 'Could not launch $url';
    }
  }


  
  Future<void> getGroupInfoDetails() async {
    try {
      final response = await _infromationRepository
          .getProfileData(selectedChatModel?.id ?? "");
      responseModel.value = response;
    } catch (e) {
      throw e;
    }
  }
}
