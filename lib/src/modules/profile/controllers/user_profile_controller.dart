import 'package:get/get.dart';
import 'package:info91/src/utils/app_utils.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';

class UserProfileController extends GetxController {
  final profileImageUrl =
      'https://www.profilebakery.com/wp-content/uploads/2023/04/Profile-Image-AI.jpg'
          .obs;

  final name = 'Arya'.obs;

  final number = '+91 987 654 3210'.obs;

  final status = 'Last seen on today 11:30 AM'.obs;

  final about = 'Hey there! I am using Info91'.obs;

  final aboutDate = 'March 21, 2024'.obs;

  void onCopy() {
    AppUtils.copyToClipBoard('number');
    AppUtils.showSnackBar('Phone number copied');
  }

  void onBlockChatPressed() {
    AppDialog.showDialog(
      title: 'Block this contact ?',
      primaryText: 'Cancel',
      onPrimaryPressed: Get.back,
      secondaryText: 'Block',
      onSecondaryPressed: Get.back,
    );
  }
}
