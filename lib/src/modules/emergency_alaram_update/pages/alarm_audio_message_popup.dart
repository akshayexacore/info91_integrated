import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';

import 'package:info91/src/modules/emergency_alaram_update/controller/emergency_update_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_avatarwithimageicon.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AlarmAudioMessagePopup extends StatefulWidget {
  final String heading;

  final VoidCallback? onSend;
  const AlarmAudioMessagePopup({super.key, required this.heading, this.onSend});

  @override
  State<AlarmAudioMessagePopup> createState() => _AlarmAudioMessagePopupState();
}

class _AlarmAudioMessagePopupState extends State<AlarmAudioMessagePopup> {
  final EmergencyUpdateController _emergencyUpdateController =
      Get.put(EmergencyUpdateController());

  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _audioDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;

  deleteFunction() async {
    if (_audioPlayer.playing) {
      await _audioPlayer.stop();
    }
    _emergencyUpdateController.filePath.value = '';
    _emergencyUpdateController.isPlaying.value = false;
    _emergencyUpdateController.isRecording.value = false;
    _audioDuration = Duration.zero;
    _currentPosition = Duration.zero;
    _emergencyUpdateController.resetRecording();
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer.durationStream.listen((duration) {
      setState(() {
        _audioDuration = duration ?? Duration.zero;
      });
    });

    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });

    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          _emergencyUpdateController.isPlaying.value = false;
          _currentPosition = Duration.zero;
          _audioPlayer.stop();
        });
        _audioPlayer.seek(Duration.zero);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: 350.w,
        height: 350.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: marginWidth, horizontal: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            greyBoldText(widget.heading, fontWeight: FontWeight.w400),
            const SizedBox(height: 15),
            Obx(() {
              return _emergencyUpdateController.filePath.value.isEmpty
                  ? Column(
                      children: [
                        greynonBoldText(
                          _emergencyUpdateController.isRecording.value
                              ? "Recording....."
                              : "Record your audio",
                          color: _emergencyUpdateController.isRecording.value
                              ? AppColors.secondary
                              : null,
                        ),
                        if (_emergencyUpdateController.isRecording.value)
                          Text(
                            _emergencyUpdateController.formatDuration(
                                _emergencyUpdateController
                                    .recordingDuration.value),
                            style: TextStyle(color: AppColors.secondary),
                          ),
                        SizedBox(height: 50.h),
                        CustomCircleIconWidget(
                          radius: 21.r,
                          iconData: Icons.mic_none,
                          iconSize: 20,
                          iconColor: AppColors.primary,
                          backgroundClr: AppColors.primary.withOpacity(.2),
                          onCange: () {},
                          onLongPress: () async {
                            if (await _recorder.hasPermission()) {
                              final Directory apdirctry =
                                  await getApplicationDocumentsDirectory();
                              final String path =
                                  join(apdirctry.path, "recording.wav");
                              await _recorder.start(RecordConfig(), path: path);

                              _emergencyUpdateController.isRecording.value =
                                  true;
                              _emergencyUpdateController.filePath.value = '';
                              _emergencyUpdateController.startRecordingTimer();
                            }
                          },
                          onLongPressEnd: () async {
                            if (_emergencyUpdateController.isRecording.value) {
                              final String? path = await _recorder.stop();
                              if (path != null) {
                                _emergencyUpdateController.isRecording.value =
                                    false;
                                _emergencyUpdateController.filePath.value =
                                    path;
                                _emergencyUpdateController.stopRecordingTimer();
                              }
                            }
                          },
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Obx(() {
                              return IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  _emergencyUpdateController.isPlaying.value
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 35.sp,
                                ),
                                onPressed: () async {
                                  if (_audioPlayer.playing) {
                                    await _audioPlayer.stop();
                                    _emergencyUpdateController.isPlaying.value =
                                        false;
                                  } else {
                                    _emergencyUpdateController.isPlaying.value =
                                        true;
                                    await _audioPlayer.setFilePath(
                                        _emergencyUpdateController
                                            .filePath.value);
                                    await _audioPlayer.play();
                                  }
                                },
                                color: AppColors.primary,
                              );
                            }),
                            Expanded(
                              child: SliderTheme(
                                data: SliderThemeData(
                                  trackHeight: 2.0,
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 6.0),
                                ),
                                child: Slider(
                                  value: _currentPosition.inMilliseconds
                                      .toDouble(),
                                  max: _audioDuration.inMilliseconds.toDouble(),min: 0,
                                  activeColor: AppColors.primary,
                                  onChanged: (value) async {
                                  final position =
                                     Duration(milliseconds: value.toInt());
                                    await _audioPlayer.seek(position);
                                    setState(() {
                                      _currentPosition = position;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_emergencyUpdateController
                                .formatDuration(_currentPosition)),
                            Text(_emergencyUpdateController.formatDuration(
                                _emergencyUpdateController
                                    .recordingDuration.value)),
                          ],
                        ),
                        SizedBox(height: 50.h),
                        CustomCircleIconWidget(
                          radius: 22.r,
                          iconSize: 21,
                          iconColor: AppColors.red,
                          iconData: Icons.delete,
                          backgroundClr: AppColors.primary.withOpacity(.2),
                          onCange: deleteFunction,
                        ),
                      ],
                    );
            }),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: "Cancel",
                    onPressed: () {
                      Get.back();
                    },
                    style: AppButtonStyles.appButton.copyWith(
                      backgroundColor: WidgetStatePropertyAll(
                          AppColors.primary.withOpacity(.1)),
                    ),
                    height: 40.h,
                    textStyle: AppTextStyles.appButton
                        .copyWith(color: AppColors.black),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: AppButton(
                    text: "Send",
                    onPressed: () {
                      if (widget.onSend != null) widget.onSend!();
                    },
                    height: 40.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
