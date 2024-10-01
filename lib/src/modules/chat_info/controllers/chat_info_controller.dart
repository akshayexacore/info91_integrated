import 'package:get/get.dart';
import 'package:info91/src/models/chat.dart';

class ChatInfoController extends GetxController {
  final chat = Chat(date: DateTime.now()).obs;

  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments;
    if (arguments != null && arguments is Chat) {
      chat(arguments);
    }
  }
}
