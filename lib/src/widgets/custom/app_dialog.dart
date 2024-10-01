import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';

class AppDialog {
  static showDialog({
    String? title,
    String? content,
    String? primaryText,
    String? secondaryText,
    String? tertiaryText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    VoidCallback? onTertiaryPressed,
    bool dismissible = true,
    double borderRadius = 0,
    bool arrangeButtonVertically = false,
    Widget? customContent,
  }) {
    return Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          width: AppSizes.alertDialog,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: arrangeButtonVertically
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              if (title != null)
                Padding(
                  padding: const EdgeInsets.all(
                    AppPaddings.xSmall10,
                  ),
                  child: Text(
                    title,
                    style: AppTextStyles.alertDialogTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              if (content != null)
                Padding(
                  padding: const EdgeInsets.all(
                    AppPaddings.xSmall10,
                  ),
                  child: Text(
                    content,
                    style: AppTextStyles.alertDialogContent,
                    textAlign: TextAlign.center,
                  ),
                ),
              if (customContent != null) customContent,
              arrangeButtonVertically
                  ? _buildDialogButtonsVertically(
                      primaryText: primaryText,
                      secondaryText: secondaryText,
                      tertiaryText: tertiaryText,
                      onPrimaryPressed: onPrimaryPressed,
                      onSecondaryPressed: onSecondaryPressed,
                      onTertiaryPressed: onTertiaryPressed,
                    )
                  : _buildDialogButtonsHorizontally(
                      primaryText: primaryText,
                      secondaryText: secondaryText,
                      onPrimaryPressed: onPrimaryPressed,
                      onSecondaryPressed: onSecondaryPressed,
                    ),
            ],
          ),
        ),
      ),
      barrierDismissible: dismissible,
    );
  }

  static showSnackBar(String title, String message) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.black,
      margin: const EdgeInsets.all(0),
      colorText: AppColors.white,
      borderRadius: 0.0,
    );
  }

  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  static Widget _buildDialogButtonsVertically({
    String? primaryText,
    String? secondaryText,
    String? tertiaryText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    VoidCallback? onTertiaryPressed,
  }) {
    return (primaryText != null ||
            secondaryText != null ||
            tertiaryText != null)
        ? Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPaddings.small14,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (primaryText != null)
                    SizedBox(
                      height: 34,
                      child: InkWell(
                        onTap: onPrimaryPressed,
                        child: Text(
                          primaryText,
                          style: AppTextStyles.appButton.copyWith(
                            fontSize: AppFontSizes.small15,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  if (secondaryText != null)
                    SizedBox(
                      height: 34,
                      child: InkWell(
                        onTap: onSecondaryPressed,
                        child: Text(
                          secondaryText,
                          style: AppTextStyles.appButton.copyWith(
                            fontSize: AppFontSizes.small15,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  if (tertiaryText != null)
                    SizedBox(
                      height: 34,
                      child: InkWell(
                        onTap: onTertiaryPressed,
                        child: Text(
                          tertiaryText,
                          style: AppTextStyles.appButton.copyWith(
                            fontSize: AppFontSizes.small15,
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )
        : const SizedBox();
  }

  static Widget _buildDialogButtonsHorizontally({
    String? primaryText,
    String? secondaryText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
  }) {
    return (primaryText != null || secondaryText != null)
        ? Column(
            children: [
              Container(
                height: 1,
                width: double.maxFinite,
                color: AppColors.offWhite,
              ),
              SizedBox(
                height: 34,
                child: Row(
                  children: [
                    if (primaryText != null)
                      Expanded(
                        child: InkWell(
                          onTap: onPrimaryPressed,
                          child: Center(
                            child: Text(
                              primaryText,
                              style: AppTextStyles.appButton.copyWith(
                                fontSize: AppFontSizes.small15,
                                color: AppColors.primary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    if (primaryText != null && secondaryText != null)
                      Container(
                        height: double.maxFinite,
                        width: 1,
                        color: AppColors.offWhite,
                      ),
                    if (secondaryText != null)
                      Expanded(
                        child: InkWell(
                          onTap: onSecondaryPressed,
                          child: Center(
                            child: Text(
                              secondaryText,
                              style: AppTextStyles.appButton.copyWith(
                                fontSize: AppFontSizes.small15,
                                color: AppColors.primary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
