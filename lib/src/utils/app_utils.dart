import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';

class AppUtils {
  AppUtils._();

  static void showSnackBar(
    String message, {
    double bottomPadding = AppPaddings.large,
  }) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: Colors.transparent,
      borderRadius: AppRadii.xSmall,
      duration: const Duration(seconds: 2),
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      messageText: Center(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(
            horizontal: AppPaddings.xSmall,
            vertical: AppPaddings.xxxSmall,
          ),
          margin: EdgeInsets.only(
            right: AppPaddings.large,
            left: AppPaddings.large,
            bottom: bottomPadding,
          ),
          child: Text(
            message,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: AppFontSizes.xxxSmall,
            ),
          ),
        ),
      ),
    ));
  }

  static void copyToClipBoard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
