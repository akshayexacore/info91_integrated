import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';

class AppEmojiPicker extends StatelessWidget {
  const AppEmojiPicker(this.controller, {super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
      /*onEmojiSelected  onEmojiSelected: (Category category, Emoji emoji) {
                      // Do something when emoji is tapped (optional)
                     },
                      onBackspacePressed: () {
                        // Do something when the user taps the backspace button (optional)
                        // Set it to null to hide the Backspace-Button
                      },*/
      textEditingController: controller,
      // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
      config: Config(
        height: 256,
        checkPlatformCompatibility: true,
        emojiViewConfig: EmojiViewConfig(
          columns: 7,
          verticalSpacing: 0,
          backgroundColor: AppColors.white,

          horizontalSpacing: 0,
          gridPadding: EdgeInsets.zero,
          // Issue: https://github.com/flutter/flutter/issues/28894
          emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
          recentsLimit: 28,
          buttonMode: ButtonMode.CUPERTINO,
        ),
        swapCategoryAndBottomBar: false,
        skinToneConfig: const SkinToneConfig(),
        categoryViewConfig: const CategoryViewConfig(
          backgroundColor: AppColors.offWhite,
          iconColorSelected: AppColors.primary,
          indicatorColor: AppColors.primary,
        ),
        bottomActionBarConfig: const BottomActionBarConfig(
          backgroundColor: AppColors.primary,
          buttonColor: AppColors.primary,
        ),
        searchViewConfig: const SearchViewConfig(),
      ),
    );
  }
}
