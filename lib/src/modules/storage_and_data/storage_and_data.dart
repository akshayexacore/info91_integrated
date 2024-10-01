import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/storage_and_data/controllers/storage_and_data_controller.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/tiny/app_back_button.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class StorageAndData extends StatelessWidget {
  StorageAndData({super.key});

  static const routeName = '/storage_and_data';

  final _controller = Get.find<StorageAndDataController>();

  @override
  Widget build(BuildContext context) {
    final bool canPop = ModalRoute.of(context)?.canPop ?? false;
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(
          color: AppColors.white,
        ),
        automaticallyImplyLeading: false,
        leadingWidth: 0,
        title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildPrimaryAppBar(canPop: canPop, key: UniqueKey())),
      ),
      body: ListView(
        children: [
          AppInkWell(
            onTap: _controller.onNetworkUsagePressed,
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
                        'assets/images/ic_storage.svg',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppSpacings.small10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Network usage',
                        style: TextStyle(
                          fontSize: AppFontSizes.small15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '98.9 MB sent . 102 MB received',
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
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPaddings.large,
            ),
            child: Divider(
              color: AppColors.white,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPaddings.large,
              vertical: AppPaddings.medium,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Media auto-download',
                  style: TextStyle(
                    fontSize: AppFontSizes.small15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          _buildOptions(
            onPressed: _controller.onWhenMobileDataPressed,
            title: 'When using mobile data',
            subtitle: 'Photos, videos',
          ),
          _buildOptions(
            onPressed:  _controller.onWhenWiFiPressed,
            title: 'When connected on Wi-Fi',
            subtitle: 'All media',
          ),
          _buildOptions(
            onPressed:  _controller.onWhenRoamingPressed,
            title: 'When roaming',
            subtitle: 'No media',
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryAppBar({
    required bool canPop,
    Key? key,
  }) {
    return Row(
      key: key,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (canPop) ...[
          AppBackButton(
            color: AppColors.white,
            onPressed: _controller.onBackPressed,
          ),
          const SizedBox(
            width: 15,
          ),
        ],
        const Text(
          'Storage and data',
          style: TextStyle(
            fontSize: AppFontSizes.small15,
            color: AppColors.white,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  _buildOptions({
    VoidCallback? onPressed,
    required String title,
    required String subtitle,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 60,
          vertical: AppPaddings.small,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: AppFontSizes.small15,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: AppFontSizes.xSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
