import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/profile.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/tiny/app_check_box.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class AppProfileTile extends StatelessWidget {
  const AppProfileTile(
    this.profile, {
    super.key,
    this.onPressed,
    this.enableCheckbox = false,
    this.selected = false,
    this.enableClose = false,
  });

  final VoidCallback? onPressed;

  final Profile profile;

  final bool enableCheckbox;

  final bool selected;

  final bool enableClose;

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: onPressed,
      child: Padding(
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
                    ],
                  ),
                  Text(
                    profile.about,
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
            if (enableCheckbox) ...[
              const SizedBox(
                width: AppSpacings.xMedium,
              ),
              AppCheckBox(value: selected),
            ],
            if (enableClose && !enableCheckbox) ...[
              const SizedBox(
                width: AppSpacings.xMedium,
              ),
              const AppSvgAsset(
                'assets/images/ic_close.svg',
                height: 24,
                width: 24,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
