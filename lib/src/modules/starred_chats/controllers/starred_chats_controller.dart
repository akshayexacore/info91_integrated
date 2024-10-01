import 'package:get/get.dart';
import 'package:info91/src/models/chat.dart';

class TempModelStarredChat {
  final String message;
  final bool own;
  final MessageStatus status;
  final String time;
  final int id;
  final bool starred;
  final String recipient;
  final String imgUrl;

  TempModelStarredChat({
    this.id = 0,
    this.message = '',
    this.own = false,
    this.status = MessageStatus.none,
    this.time = '',
    this.starred = true,
    this.recipient = '',
    this.imgUrl = '',
  });

  static List<TempModelStarredChat> dummyList() => [
        TempModelStarredChat(
          id: 1,
          imgUrl:
              'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg',
          message: 'How are you doing today?',
          status: MessageStatus.seen,
          recipient: 'Ary',
          time: '4:20 PM',
          own: false,
        ),
        TempModelStarredChat(
          id: 2,
          imgUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzOuEOtYScMiWM_kWau4NvafPSaIaXfo71Tp_nea7lYw&s',
          message: 'Have a nice day',
          status: MessageStatus.delivered,
          recipient: 'Arya',
          time: '4:10 PM',
          own: true,
        ),
      ];
}

class StarredChatsController extends GetxController {
  final chats = <TempModelStarredChat>[].obs;

  final selectedChatIndexes = <int>[].obs;

  final containsOnlyStarredMessage = true.obs;

  void onBackPressed() {
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    chats(TempModelStarredChat.dummyList());
  }

  void onChatLongPressed(int index) {
    if (selectedChatIndexes.isEmpty) {
      selectedChatIndexes.add(chats[index].id);
    }
  }

  void onClearSelected() {
    selectedChatIndexes.clear();
  }

  void onChatPressed(int index) {
    if (selectedChatIndexes.isNotEmpty) {
      if (!selectedChatIndexes.contains(chats[index].id)) {
        selectedChatIndexes.add(chats[index].id);
      } else {
        selectedChatIndexes.remove(chats[index].id);
      }
    }
  }

  void onUnStarAllPressed() {}

  void onStarPressed() {
    for (int id in selectedChatIndexes) {
      try {
        final index = chats.indexWhere((element) => element.id == id);
        chats.remove(index);
      } catch (_) {}
    }
    selectedChatIndexes.clear();
  }
}
