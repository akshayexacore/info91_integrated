import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:info91/src/models/informationgroup/information_group.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/chat_screen/info_group_chat_screen.dart';
import 'package:info91/src/resources/infromation_repository.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';

class StarScreenController extends GetxController {
  late InfoGroupChatListModel? selectedChatModel;
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
    super.onInit();
  }

  Future<void> joinMessageTapFunc() async {
    try {
      final response = await _infromationRepository
          .joinMessageTapFunc(selectedChatModel?.id ?? "");
      if (response.data1) {
          AppDialog.showSnackBar('Suceess', '${response.data2}');
        Get.to(ChatScreen());
      } else {
        AppDialog.showSnackBar('Failure', '${response.data2}');
      }
    } catch (e) {
      throw e;
    }
  }
}
