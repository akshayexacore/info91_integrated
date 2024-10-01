import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/storage_and_data/storage_and_data.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class SettingsController extends GetxController {
  final profileImageUrl =
      'https://www.profilebakery.com/wp-content/uploads/2023/04/Profile-Image-AI.jpg'
          .obs;

  final name = 'Basil'.obs;

  final about = 'Hey there! I am using Info91'.obs;

  void onLanguagePressed() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppPaddings.small,
          ),
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 3,
                width: 32,
                color: AppColors.text,
              ),
              AppInkWell(
                onTap: Get.back,
                child: const Padding(
                  padding: EdgeInsets.all(
                    AppPaddings.large,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 34,
                        width: 34,
                        child: Center(
                          child: AppSvgAsset(
                            'assets/images/ic_close.svg',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: AppSpacings.small10,
                      ),
                      Text(
                        'App language',
                        style: TextStyle(
                          fontSize: AppFontSizes.small15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              AppInkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(
                    AppPaddings.large,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 34,
                        width: 34,
                        child: Center(
                          child: Radio(
                              value: true,
                              groupValue: true,
                              onChanged: (value) {}),
                        ),
                      ),
                      const SizedBox(
                        width: AppSpacings.small10,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'English',
                            style: TextStyle(
                              fontSize: AppFontSizes.small15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '(Device language)',
                            style: TextStyle(
                              fontSize: AppFontSizes.xSmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void onStorageAndDataPressed() {
    Get.toNamed(StorageAndData.routeName);
  }
}
