import 'dart:async';

import 'package:get/get.dart';
import 'package:info91/src/modules/emergency_alaram_update/pages/verify_number_screen.dart';

class EmergencyUpdateController extends GetxController {
  var isRecording = false.obs;
  var isPlaying = false.obs;
  var filePath = ''.obs;
  var recordingDuration = Duration.zero.obs;

  Timer? _recordingTimer;

  void startRecordingTimer() {
    recordingDuration.value = Duration.zero;
    _recordingTimer?.cancel();
    _recordingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      recordingDuration.value += Duration(seconds: 1);
    });
  }

  void stopRecordingTimer() {
    _recordingTimer?.cancel();
  }

  void resetRecording() {
    recordingDuration.value = Duration.zero;
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }




}
