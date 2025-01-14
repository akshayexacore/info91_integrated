import 'package:get/get.dart';
import 'package:info91/src/models/informationgroup/chat_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'dart:convert';

class WebSocketController extends GetxController {
  late WebSocketChannel channel;
  var messages = <ChatMessage>[].obs;
  var isConnected = false.obs;

  void connect(String url) {
    channel = WebSocketChannel.connect(Uri.parse(url));
    channel.stream.listen(
      (event) {
        print("the event is here");
        final data = jsonDecode(event);
        messages.add(ChatMessage.fromJson(data));
      },
      onDone: _handleDisconnect,
      onError: (error) {
        _handleDisconnect();
      },
    );
    isConnected.value = true;
  }

  void sendMessage(ChatMessage message) {
    final jsonMessage = jsonEncode(message.toJson());
    channel.sink.add(jsonMessage);
  }

  void _handleDisconnect() {
    isConnected.value = false;
    reconnect();
  }

  void reconnect() {
    if (!isConnected.value) {
      connect('wss://info91.exacore.co.in:6001'); // Replace with your WebSocket URL
    }
  }

  @override
  void onClose() {
    channel.sink.close(status.goingAway);
    super.onClose();
  }
}
