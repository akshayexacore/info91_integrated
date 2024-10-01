import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/group.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/custom/app_message_status.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class AppMessageGroupTile extends StatelessWidget {
  const AppMessageGroupTile(
    this.group, {
    super.key,
    this.onPressed,
    this.onLongPress,
  });

  final VoidCallback? onPressed;

  final VoidCallback? onLongPress;

  final Group group;

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: onPressed,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPaddings.large,
        ),
        child: Row(
          children: [
            AppCircleImage(
              image: group.imgUrl,
              radius: 24,
            ),
            const SizedBox(
              width: AppSpacings.small14,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: AppSpacings.xMedium22,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          group.name,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: AppFontSizes.small15,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: AppSpacings.xSmall,
                      ),
                      AppMessageStatus(
                        messageStatus: group.messageStatus,
                        time: group.lastMessageTime,
                      )
                    ],
                  ),
                  Text(
                    group.lastMessage,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: AppFontSizes.small,
                    ),
                  ),
                  const SizedBox(
                    height: AppSpacings.xMedium,
                  ),
                  const Divider(
                    height: 1,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: AppSpacings.small14,
            ),
          ],
        ),
      ),
    );
  }
}
