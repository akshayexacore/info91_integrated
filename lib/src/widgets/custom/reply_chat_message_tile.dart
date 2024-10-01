import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class ReplyChatMessageTile extends StatelessWidget {
  const ReplyChatMessageTile({
    super.key,
    this.onClose,
    required this.message,
  });

  final String message;

  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(2, 2),
              blurRadius: 2,
              color: AppColors.black.withOpacity(0.25),
            )
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(
                AppRadii.xSmall,
              ),
              topRight: Radius.circular(
                AppRadii.xSmall,
              )),
          border: const Border(
            left: BorderSide(
              color: AppColors.primary,
              width: 5,
            ),
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPaddings.medium16,
              vertical: AppPaddings.xSmall,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Arya',
                        style: TextStyle(
                          fontSize: AppFontSizes.small15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        message,
                        style: const TextStyle(
                          fontSize: AppFontSizes.small,
                        ),
                      ),
                    ],
                  ),
                ),
                AppInkWell(
                  onTap: onClose,
                  child: const AppSvgAsset(
                    'assets/images/ic_close.svg',
                    width: 20,
                    height: 20,
                  ),
                )
              ],
            )));
  }
}
