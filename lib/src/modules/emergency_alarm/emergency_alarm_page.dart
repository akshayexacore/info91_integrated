import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/emergency_alarm/controllers/emergency_alarm_controller.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/custom/app_profile_tile.dart';
import 'package:info91/src/widgets/tiny/app_back_button.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class EmergencyAlarmPage extends StatelessWidget {
  EmergencyAlarmPage({super.key});

  static const routeName = '/emergency_alarm';

  final _controller = EmergencyAlarmController.get();

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
        titleSpacing: 10,
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildAppBar(canPop: canPop),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPaddings.large,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: AppPaddings.small14,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(AppRadii.xSmall)),
                    border: Border.all(
                      color: AppColors.black.withOpacity(0.25),
                    ),
                  ),
                  child: AppInkWell(
                    onTap: _controller.onAddRecipients,
                    borderRadius: AppRadii.xSmall,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPaddings.small14,
                        vertical: AppPaddings.xSmall,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppSvgAsset('assets/images/ic_add_circle.svg'),
                          SizedBox(
                            width: AppSpacings.small10,
                          ),
                          Text(
                            'Add recipients',
                            style: TextStyle(
                              fontSize: AppFontSizes.small15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: AppColors.white,
                  height: 1,
                )
              ],
            ),
          ),
          const SizedBox(
            height: AppSpacings.xSmall,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPaddings.large,
            ),
            child: Text(
              '3 recipients',
              style: TextStyle(
                fontSize: AppFontSizes.xSmall,
              ),
            ),
          ),
          Obx(() {
            return Column(
              children: _controller.profiles
                  .map((profile) => AppProfileTile(
                        profile,
                      ))
                  .toList(),
            );
          }),
          const SizedBox(
            height: AppSpacings.xSmall,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPaddings.large,
            ),
            child: Text(
              'Description',
              style: TextStyle(
                fontSize: AppFontSizes.xSmall,
              ),
            ),
          ),
          const SizedBox(
            height: AppPaddings.xxSmall,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: AppPaddings.large,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppPaddings.xSmall10,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppRadii.xSmall)),
              border: Border.all(
                color: AppColors.black.withOpacity(0.25),
              ),
            ),
            child: const TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              maxLines: 4,
            ),
          ),
          const SizedBox(
            height: AppPaddings.small14,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppPaddings.large,
            ),
            child: Text(
              'My live location',
              style: TextStyle(
                fontSize: AppFontSizes.small15,
              ),
            ),
          ),
          const SizedBox(
            height: AppPaddings.xSmall10,
          ),
          Stack(
            children: [
              const AppNetworkImage(
                'https://i.imgur.com/QuoSnPA.png',
                height: 300,
                fit: BoxFit.fill,
              ),
              Positioned(
                bottom: AppSpacings.xxLarge50,
                left: AppPaddings.large,
                right: AppPaddings.large,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPaddings.large,
                  ),
                  child: AppButton(
                    text: 'Send emergency alarm',
                    style: AppButtonStyles.appButton.copyWith(
                        backgroundColor: const WidgetStatePropertyAll(
                      AppColors.red,
                    )),
                    onPressed: _controller.onSendEmergencyPressed,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAppBar({
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
            onPressed: Get.back,
          ),
          const SizedBox(
            width: 15,
          ),
        ],
        const Text(
          'Emergency Alarm',
          style: TextStyle(
            fontSize: AppFontSizes.small15,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}
