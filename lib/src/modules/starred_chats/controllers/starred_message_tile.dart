import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/starred_chats/controllers/starred_chats_controller.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/custom/app_message_status.dart';
import 'package:info91/src/widgets/tiny/app_check_box.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class StarredChatMessageTile extends StatelessWidget {
  const StarredChatMessageTile({
    Key? key,
    required this.chat,
    this.onLongPress,
    this.onPressed,
    this.selected = false,
  }) : super(key: key);

  final TempModelStarredChat chat;

  final VoidCallback? onLongPress;

  final VoidCallback? onPressed;

  final bool selected;

  final double _endPadding = 100;

  final double _selectedIconSize = 22;

  final double _selectedIconSpacing = 10;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: selected ? AppColors.primary.withOpacity(0.1) : null,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPaddings.large,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (selected) ...[
                AppCheckBox(
                  value: selected,
                ),
                SizedBox(
                  width: _selectedIconSpacing,
                ),
              ],
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppPaddings.small14 / 2,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppCircleImage(
                            radius: 11,
                            image: chat.imgUrl,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            chat.own
                                ? 'You - ${chat.recipient}'
                                : '${chat.recipient} - You',
                            style: const TextStyle(
                              fontSize: AppFontSizes.xxxSmall,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      AppInkWell(
                        borderRadius: AppRadii.medium10,
                        onLongPress: onPressed == null
                            ? () {
                                onLongPress?.call();
                              }
                            : null,
                        child: Container(
                            key: UniqueKey(),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(
                                  AppRadii.medium10,
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chat.message,
                                  style: const TextStyle(
                                    color: AppColors.text,
                                    fontSize: AppFontSizes.small,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (chat.own) ...[
                                      AppMessageStatus(
                                        messageStatus: chat.status,
                                      ),
                                      const SizedBox(
                                        width: AppSpacings.xxSmall,
                                      ),
                                    ],
                                    const Text(
                                      '6:00 am',
                                      style: TextStyle(
                                        color: AppColors.lightText,
                                        fontSize: AppFontSizes.xxxSmall,
                                      ),
                                    ),
                                    ...[
                                      const SizedBox(
                                        width: AppSpacings.xxSmall,
                                      ),
                                      const AppSvgAsset(
                                        'assets/images/ic_star_fill.svg',
                                        color: AppColors.secondary,
                                        height: 9,
                                        width: 9,
                                      )
                                    ],
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: _endPadding -
                    (selected ? _selectedIconSize + _selectedIconSpacing : 0),
              ),
            ],
          ),
        ),
        if (onPressed != null)
          Positioned.fill(
            child: AppInkWell(
              onTap: onPressed,
            ),
          ),
      ],
    );
  }
}
