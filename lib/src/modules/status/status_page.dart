import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/status/controllers/status_controller.dart';
import 'package:info91/src/widgets/custom/app_status_tile.dart';

class StatusPage extends StatelessWidget {
  StatusPage({super.key});

  final _controller = Get.find<StatusController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppPaddings.large,
          vertical: AppPaddings.medium,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Status',
              style: TextStyle(
                fontSize: AppFontSizes.small15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: AppSpacings.small16,
            ),
            AppStatusTile(
              isOwner: true,
              status: _controller.myStatus,
            ),
            const SizedBox(
              height: AppSpacings.xSmall,
            ),
            const Divider(),
            const SizedBox(
              height: AppSpacings.xxSmall,
            ),
            const Text(
              'Recents',
              style: TextStyle(
                fontSize: AppFontSizes.small15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: AppSpacings.small,
            ),
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return AppStatusTile(
                  status: _controller.unseenStatuses[index],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: AppSpacings.xMedium,
              ),
              itemCount: _controller.unseenStatuses.length,
            ),
            const SizedBox(
              height: AppSpacings.xSmall,
            ),
            const Divider(),
            Row(
              children: [
                const Text(
                  'Viewed Status',
                  style: TextStyle(
                    fontSize: AppFontSizes.small15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Obx(
                  () => IconButton(
                      onPressed: () {
                        _controller.seenStatusShow.toggle();
                      },
                      icon: Icon(
                        _controller.seenStatusShow.isTrue
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        size: 28,
                      )),
                )
              ],
            ),
            const SizedBox(
              height: AppSpacings.xxSmall,
            ),
            Obx(() {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                child: _controller.seenStatusShow.isFalse
                    ? const SizedBox()
                    : ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, indexSeen) {
                          return AppStatusTile(
                            status: _controller.seenStatuses[indexSeen],
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: AppSpacings.xMedium,
                        ),
                        itemCount: _controller.seenStatuses.length,
                      ),
              );
            }),
            const SizedBox(
              height: AppSpacings.xSmall,
            ),
            const SizedBox(
              height: AppSpacings.xMedium,
            ),
          ],
        ),
      ),
    );
  }
}
