import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/network_usage/network_usage_page.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class StorageAndDataController extends GetxController {
  void onBackPressed() {
    Get.back();
  }

  void onNetworkUsagePressed() {
    Get.toNamed(NetworkUsagePage.routeName);
  }

  void onWhenMobileDataPressed() {
    AppDialog.showDialog(
      // title: 'When using mobile data',
      secondaryText: 'Ok',
      primaryText: 'Cancel',
      onSecondaryPressed: Get.back,
      onPrimaryPressed: Get.back,
      borderRadius: 8,
      customContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(
              AppPaddings.large,
            ),
            child: Text(
              'When using mobile data',
              style: AppTextStyles.alertDialogTitle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: AppSpacings.xxSmall,
          ),
          _buildCheckboxListTile(
            value: true,
            onChanged: (value) {},
            title: 'Photos',
          ),
          _buildCheckboxListTile(
            value: false,
            onChanged: (value) {},
            title: 'Audio',
          ),
          _buildCheckboxListTile(
            value: false,
            onChanged: (value) {},
            title: 'Videos',
          ),
          _buildCheckboxListTile(
            value: false,
            onChanged: (value) {},
            title: 'Documents',
          ),
          const SizedBox(
            height: AppSpacings.small,
          ),
        ],
      ),
    );
  }

  _buildCheckboxListTile({
    bool value = false,
    Function(bool value)? onChanged,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppPaddings.xSmall10,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            width: AppSpacings.xMedium22,
          ),
          AppSvgAsset(
            'assets/images/${value ? 'ic_checkbox_selected.svg' : 'ic_checkbox_unselected.svg'}',
          ),
          const SizedBox(
            width: AppSpacings.small16,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: AppFontSizes.xSmall,
            ),
          ),
        ],
      ),
    );
  }

  void onWhenWiFiPressed() {
    onWhenMobileDataPressed();
  }

  void onWhenRoamingPressed() {
    onWhenMobileDataPressed();
  }
}
