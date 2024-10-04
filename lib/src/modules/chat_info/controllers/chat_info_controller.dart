import 'package:get/get.dart';
import 'package:info91/src/models/chat.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/chat_screen/info_group_chat_screen.dart';

class ChatInfoController extends GetxController {
  final chat = Chat(date: DateTime.now()).obs;
  late ChatMessage chatMessage;
 var isChatType=true.obs;
  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments;






    if (arguments != null ) {
      if(arguments is Chat){
        isChatType.value=true;
        chat(arguments);
      }
      
      if(arguments is ChatMessage){
         isChatType.value=false;
        chatMessage=  arguments;
        print("chatmessssssssssss${chatMessage.id}");
      }
     
    }
  }
}
