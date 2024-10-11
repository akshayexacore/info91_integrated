import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/emergency_alaram_update/controller/emergency_update_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_arrow_button.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_avatarwithimageicon.dart';

import 'package:info91/src/modules/information_groups/presentation/widgets/custom_popupmenu.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/new_input_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';
import 'package:info91/src/widgets/tiny/app_round_button.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class EmergencyMainPage extends StatefulWidget {
  EmergencyMainPage({super.key});
  static const routeName = '/emergency_alarm_mainPage';

  @override
  State<EmergencyMainPage> createState() => _EmergencyMainPageState();
}

class _EmergencyMainPageState extends State<EmergencyMainPage> {
  final EmergencyUpdateController _emergencyUpdateController =
      Get.put(EmergencyUpdateController());
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _audioDuration = Duration.zero;

  Duration _currentPosition = Duration.zero;

  var gap = SizedBox(
    height: 15.h,
  );
  deleteFunction() async {
    if (_audioPlayer.playing) {
      await _audioPlayer.stop();
    }
    _emergencyUpdateController.filePath.value = '';
    _emergencyUpdateController.isPlaying.value = false;
    _emergencyUpdateController.isRecording.value = false;
    _audioDuration = Duration.zero;

    _currentPosition = Duration.zero;
  }

  @override
  void initState() {
    super.initState();
    // Listen to audio duration and position
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
        _audioPlayer.seek(Duration.zero); // Reset position to the start
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            appBarName: "Emergency Alarm",
            actionWidget: [
              CustomPopupmenu(
                onSelected: (val) {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) =>
                  //           const InformGroupCreationScreen(),
                  //     ));
                },
                itemList: [
                  popupMenuModel(name: "Create Alarm Group", value: 1)
                ],
              ),
            ],
            isTextield: true,
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: marginWidth, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                greyBoldText("Create Groups", color: AppColors.text),
                gap,
                CustomArrowTextbutton(
                  buttonName: "Groups",
                  onTap: () {},
                ),
                gap,
                greyBoldText("New Emergency Alarm", color: AppColors.text),
                gap,
                NewInputCard(
                  controller: TextEditingController(),
                  title: "Select Type",
                  label: "Default",
                  isBorder: true,
                ),
                SizedBox(
                  height: 15.h,
                ),
                gap,
                NewInputCard(
                  controller: TextEditingController(),
                  title: "Select Group",
                  label: "Default",
                  isBorder: true,
                ),
                SizedBox(
                  height: 15.h,
                ),
                gap,
                NewInputCard(
                  controller: TextEditingController(),
                  title: "Select Keywords",
                  label: "Default",
                  isBorder: true,
                ),
                SizedBox(
                  height: 15.h,
                ),
                NewInputCard(
                  controller: TextEditingController(),
                  title: "Message",
                  label: "Enter your message here",
                  maxLines: 3,
                  height: 90,
                  isBorder: true,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Obx(() {
                  return _emergencyUpdateController.filePath.value.isEmpty
                      ? Row(
                          children: [
                            greynonBoldText(
                              _emergencyUpdateController.isRecording.value
                                  ? "Recording"
                                  : "Record your audio",
                            ),
                            Spacer(),
                            CustomCircleIconWidget(
                              radius: 21.r,
                              iconData: Icons.mic_none,
                              iconSize: 20,
                              iconColor: AppColors.black,
                              backgroundClr: AppColors.primary.withOpacity(.2),
                              onCange: () {},
                              onLongPress: () async {
                                if (await _recorder.hasPermission()) {
                                  final Directory apdirctry =
                                      await getApplicationDocumentsDirectory();
                                  final String path =
                                      join(apdirctry.path, "recording.wav");
                                  await _recorder.start(RecordConfig(),
                                      path: path);

                                  _emergencyUpdateController.isRecording.value =
                                      true;
                                  _emergencyUpdateController.filePath.value =
                                      '';
                                }
                              },
                              onLongPressEnd: () async {
                                if (_emergencyUpdateController
                                    .isRecording.value) {
                                  final String? path = await _recorder.stop();
                                  if (path != null) {
                                    _emergencyUpdateController
                                        .isRecording.value = false;
                                    _emergencyUpdateController.filePath.value =
                                        path;
                                  }
                                }
                              },
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Obx(() {
                                  return IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                          _emergencyUpdateController
                                                  .isPlaying.value
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          size: 35.sp),
                                      onPressed: () async {
                                        if (_audioPlayer.playing) {
                                          await _audioPlayer.stop();
                                          _emergencyUpdateController
                                              .isPlaying.value = false;
                                        } else {
                                          _emergencyUpdateController
                                              .isPlaying.value = true;
                                          await _audioPlayer.setFilePath(
                                              _emergencyUpdateController
                                                  .filePath.value);
                                          await _audioPlayer.play();
                                        }
                                      },
                                      color: AppColors.primary);
                                }),
                                Expanded(
                                  child: Slider(
                                    value: _currentPosition.inMilliseconds
                                        .toDouble(),
                                    max: _audioDuration.inMilliseconds
                                        .toDouble(),
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
                                CustomCircleIconWidget(
                                  radius: 21.r,
                                  iconSize: 20,
                                  iconColor: AppColors.black,
                                  iconData: Icons.delete,
                                  backgroundClr:
                                      AppColors.primary.withOpacity(.2),
                                  onCange: () {
                                    deleteFunction();
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(formatDuration(_currentPosition)),
                                Text(formatDuration(_audioDuration)),
                              ],
                            ),
                          ],
                        );
                }),

                // Show progress bar only if there is a recording

                SizedBox(
                  height: 15.h,
                ),
                AppButton(
                  text: "Send",
                  onPressed: () {},
                )
              ],
            ),
          )))
        ],
      ),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
