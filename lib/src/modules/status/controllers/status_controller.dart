import 'package:get/get.dart';
import 'package:info91/src/models/status.dart';

class StatusController extends GetxController {
  final profileImageUrl =
      'https://www.profilebakery.com/wp-content/uploads/2023/04/Profile-Image-AI.jpg'
          .obs;

  final name = 'Basil'.obs;

  final about = 'Hey there! I am using Info91'.obs;

  final myStatus = Status.mine;
  final unseenStatuses = Status.dummyList();
  final seenStatuses = Status.dummyListSeen();

  final seenStatusShow = true.obs;
}
