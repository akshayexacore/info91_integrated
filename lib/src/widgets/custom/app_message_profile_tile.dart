import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/profile.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/custom/app_message_status.dart';
import 'package:info91/src/widgets/tiny/app_check_box.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class AppMessageProfileTile extends StatelessWidget {
  const AppMessageProfileTile(
    this.profile, {
    super.key,
    this.onPressed,
    this.onLongPress,
    this.selected,
  });

  final VoidCallback? onPressed;

  final VoidCallback? onLongPress;

  final Profile profile;

  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: onPressed,
      onLongPress: onLongPress,
      child: Container(
        color: selected != null && selected!
            ? AppColors.primary.withOpacity(0.1)
            : null,
        padding: const EdgeInsets.symmetric(
          horizontal: AppPaddings.large,
        ),
        child: Row(
          children: [
            AppCircleImage(
              image: profile.imgUrl,
              radius: 24,
            ),
            const SizedBox(
              width: 14,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 22,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          profile.name,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      AppMessageStatus(
                        messageStatus: profile.messageStatus,
                        time: profile.lastMessageTime,
                      )
                    ],
                  ),
                  Text(
                    profile.lastMessage,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    height: 1,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            if (selected != null) AppCheckBox(value: selected!)
          ],
        ),
      ),
    );
  }
}
