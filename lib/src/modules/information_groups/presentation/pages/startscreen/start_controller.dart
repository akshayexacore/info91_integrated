import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:info91/src/models/informationgroup/group_profile.dart';
import 'package:info91/src/models/informationgroup/information_group.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/chat_screen/info_group_chat_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/info_chatlist/info_chatlist_controller.dart';
import 'package:info91/src/resources/infromation_repository.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class StarScreenController extends GetxController {
var selectedChatModel = Rxn<InfoGroupChatListModel>();
  var responseModel = GroupProfileModel().obs;
  final _infromationRepository = InfromationRepository();
   final InfoChatListController controller = Get.put(InfoChatListController());
  @override
  void onInit() {
    if (Get.arguments != null &&
        Get.arguments['group'] is InfoGroupChatListModel) {
      selectedChatModel .value= Get.arguments['group'] as InfoGroupChatListModel;
   
    } else {
      debugPrint('No group data found in Get.arguments');
    }
    getGroupInfoDetails();
    super.onInit();
  }

  Future<void> joinMessageTapFunc() async {
    try {
      if (selectedChatModel.value?.joinedGroupFlag == true) {
        Get.to(ChatScreen(
          selectedGroupId: selectedChatModel.value?.id,
          model: responseModel.value,
        ));
      } else {
        final response = await _infromationRepository
            .joinMessageTapFunc(selectedChatModel.value?.id ?? "");
        if (response.data1) {
          AppDialog.showSnackBar('Suceess', '${response.data2}');
          Get.to(ChatScreen(
            selectedGroupId: selectedChatModel.value?.id,
            model: responseModel.value,
          ))?.then((value)async {
            if (value) 
           await controller.grtInfoGroupList();
           selectedChatModel.value=controller.totalGroupList[controller. totalGroupList.indexWhere((item) => item.id == selectedChatModel.value?.id)];
          });
          ;
        } else {
          AppDialog.showSnackBar('Failure', '${response.data2}');
        }
      }
    } catch (e) {
      throw e;
    }
  }

  contactClickFun() {
    Get.toNamed('/group_info', arguments: {"group_id":selectedChatModel.value?.id,"non_edit":true});
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
          .getProfileData(selectedChatModel.value?.id ?? "");
      responseModel.value = response;
    } catch (e) {
      throw e;
    }
  }
}
