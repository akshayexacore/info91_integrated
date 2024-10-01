import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/network_usage/controllers/network_usage_controller.dart';
import 'package:info91/src/widgets/tiny/app_back_button.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class NetworkUsagePage extends StatelessWidget {
  NetworkUsagePage({super.key});

  static const routeName = '/network_usage';

  final _controller = Get.find<NetworkUsageController>();

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPaddings.otpContent + AppSpacings.xMedium,
              vertical: AppPaddings.otpInputPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Usage',
                  style: TextStyle(
                    fontSize: AppFontSizes.small15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: AppSpacings.xMedium,
                ),
                const Text(
                  '200.9 MB',
                  style: TextStyle(
                    fontSize: AppFontSizes.large,
                  ),
                ),
                const SizedBox(
                  height: AppSpacings.xxLarge,
                ),
                Row(
                  children: [
                    _buildSentDataValue(),
                    const SizedBox(
                      width: AppSpacings.xxxLarge,
                    ),
                    _buildReceivedDataValue(),
                  ],
                ),
                const SizedBox(
                  height: AppSpacings.xxLarge + AppSpacings.small,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPaddings.large,
              ),
              child: Column(
                children: [
                  _buildProgress(
                    progress: 100,
                    title: 'Media',
                    sentValue: '98.9 MB',
                    receivedValue: '102 MB',
                    icon: 'ic_image.svg',
                  ),
                  const SizedBox(
                    height: AppSpacings.xxLarge,
                  ),
                  _buildProgress(
                    progress: 0,
                    title: 'Messages',
                    sentValue: '0 KB',
                    receivedValue: '0 KB',
                    icon: 'ic_chat.svg',
                  ),
                  const SizedBox(
                    height: AppSpacings.xxLarge,
                  ),
                  _buildProgress(
                    progress: 0,
                    title: 'Roaming',
                    sentValue: '0 KB',
                    receivedValue: '0 KB',
                    icon: 'ic_language.svg',
                  ),
                  const SizedBox(
                    height: AppSpacings.xxLarge,
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: const EdgeInsets.all(
                          AppPaddings.small,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: AppColors.black.withOpacity(0.25))),
                        child: const Text(
                          'Reset statistics',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: AppSpacings.xxLarge,
                  ),
                ],
              ),
            ),
          )
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
          'Network usage',
          style: TextStyle(
            fontSize: AppFontSizes.small15,
            color: AppColors.white,
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildSentDataValue() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: 20,
            child:
                Center(child: AppSvgAsset('assets/images/ic_sent_arrow.svg'))),
        SizedBox(
          width: AppSpacings.small10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sent',
              style: TextStyle(
                fontSize: AppFontSizes.small15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '98.9 MB',
              style: TextStyle(
                fontSize: AppFontSizes.small15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReceivedDataValue() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: 20,
            child: Center(
                child: AppSvgAsset('assets/images/ic_received_arrow.svg'))),
        SizedBox(
          width: AppSpacings.small10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Received',
              style: TextStyle(
                fontSize: AppFontSizes.small15,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '102 MB',
              style: TextStyle(
                fontSize: AppFontSizes.small15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildSentProgress(String title, String s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: AppFontSizes.xSmall,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          s,
          style: const TextStyle(
            fontSize: AppFontSizes.xxxSmall,
          ),
        ),
      ],
    );
  }

  _buildProgress({
    required double progress,
    required String title,
    required String sentValue,
    required String receivedValue,
    required String icon,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 22,
          width: 22,
          child: AppSvgAsset(
            'assets/images/$icon',
            color: AppColors.text,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(
          width: AppSpacings.small10,
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: AppFontSizes.small15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  _buildSentProgress('Sent', sentValue),
                  const SizedBox(
                    width: AppPaddings.otpContent,
                  ),
                  _buildSentProgress('Received', receivedValue),
                ],
              ),
              const SizedBox(
                height: AppPaddings.xxSmall,
              ),
              LinearProgressIndicator(
                value: progress,
                color: AppColors.greenShade,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
