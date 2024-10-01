import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/emergency_alarm/active_indicator.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class EmergencyAlarmRing extends StatelessWidget {
  const EmergencyAlarmRing({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppPaddings.large,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppPaddings.large,
        vertical: AppPaddings.xxLarge,
      ),
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(AppRadii.xSmall)),
      ),
      child: Material(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Stack(
              children: [
                ActiveIndicator(),
                Positioned.fill(
                    child: Center(
                        child: AppSvgAsset(
                  'assets/images/ic_emergency_alarm.svg',
                  height: 36,
                  width: 36,
                )))
              ],
            ),
            const Text(
              'Emergency Alarm',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.red,
              ),
            ),
            const SizedBox(
              height: AppSpacings.small14,
            ),
            const Text(
              'Basil',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: AppSpacings.xMedium,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppPaddings.large,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppPaddings.medium,
                vertical: AppPaddings.xSmall10,
              ),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.all(Radius.circular(AppRadii.xSmall)),
                border: Border.all(
                  color: AppColors.black.withOpacity(0.25),
                ),
              ),
              height: 87,
              child: const Text(
                'Hi,\nI need a help, my car got breakdown.',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(
              height: AppSpacings.xxMedium,
            ),
            AppButton(
              text: 'Send emergency alarm',
              textStyle: const TextStyle(
                color: AppColors.black,
              ),
              style: AppButtonStyles.appButton.copyWith(
                  backgroundColor: const WidgetStatePropertyAll(
                AppColors.white,
              )),
              onPressed: () {},
              shadow: true,
            ),
            const SizedBox(
              height: AppSpacings.xxMedium,
            ),
            AppButton(
              text: 'Send emergency alarm',
              style: AppButtonStyles.appButton.copyWith(
                  backgroundColor: const WidgetStatePropertyAll(
                AppColors.green,
              )),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
