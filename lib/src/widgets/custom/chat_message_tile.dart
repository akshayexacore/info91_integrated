import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/chat.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/custom/app_message_status.dart';
import 'package:info91/src/widgets/tiny/app_check_box.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class ChatMessageTile extends StatelessWidget {
  const ChatMessageTile({
    Key? key,
    required this.chat,
    this.onLongPress,
    this.onPressed,
    this.selected = false,
  }) : super(key: key);

  final Chat chat;

  final Function(Offset position)? onLongPress;

  final VoidCallback? onPressed;

  final bool selected;

  final double _endPadding = 50;

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
            mainAxisAlignment:
                chat.own ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!chat.own && selected) ...[
                AppCheckBox(
                  value: selected,
                ),
                SizedBox(
                  width: _selectedIconSpacing,
                ),
              ],
              if (chat.own)
                SizedBox(
                  width: _endPadding -
                      (selected ? _selectedIconSize + _selectedIconSpacing : 0),
                ),
              Flexible(
                child: Stack(
                  children: [
                    LayoutBuilder(builder: (context, constraints) {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: (chat.reaction.isEmpty
                                  ? AppPaddings.small14
                                  : AppPaddings.mediumX) /
                              2,
                          bottom: chat.reaction.isEmpty
                              ? AppPaddings.small14 / 2
                              : 25,
                        ),
                        child: AppInkWell(
                          borderRadius: AppRadii.medium10,
                          onLongPress: onPressed == null
                              ? () {
                                  RenderBox box =
                                      context.findRenderObject() as RenderBox;
                                  Offset position =
                                      box.localToGlobal(Offset.zero);
                                  onLongPress?.call(position);
                                }
                              : null,
                          child: Container(
                              key: UniqueKey(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                  color: chat.own
                                      ? AppColors.ownChatBg
                                      : AppColors.white,
                                  borderRadius: BorderRadius.circular(
                                    AppRadii.medium10,
                                  )),
                              child: Column(
                                crossAxisAlignment: chat.own
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  if (!chat.deleted)
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
                                      if (chat.own &&
                                          chat.starred &&
                                          !chat.deleted) ...[
                                        const AppSvgAsset(
                                          'assets/images/ic_star_fill.svg',
                                          color: AppColors.secondary,
                                          height: 9,
                                          width: 9,
                                        ),
                                        const SizedBox(
                                          width: AppSpacings.xxSmall,
                                        ),
                                      ],
                                      Flexible(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (chat.deleted) ...[
                                              SizedBox(
                                                height: 14,
                                                width: 14,
                                                child: AppSvgAsset(
                                                  'assets/images/ic_block.svg',
                                                  color: AppColors.text
                                                      .withOpacity(0.4),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: AppPaddings.xxxSmall4,
                                              ),
                                            ],
                                            if (chat.deleted)
                                              Flexible(
                                                child: Text(
                                                  'This message was deleted',
                                                  style: TextStyle(
                                                    color: AppColors.text
                                                        .withOpacity(0.4),
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                              ),
                                            const SizedBox(
                                              width: AppPaddings.xxxSmall4,
                                            ),
                                            const Text(
                                              '6:00 am',
                                              style: TextStyle(
                                                color: AppColors.lightText,
                                                fontSize: AppFontSizes.xxxSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (!chat.own &&
                                          chat.starred &&
                                          !chat.deleted) ...[
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
                                      if (chat.own && !chat.deleted) ...[
                                        const SizedBox(
                                          width: AppSpacings.xxSmall,
                                        ),
                                        AppMessageStatus(
                                          messageStatus: chat.status,
                                        )
                                      ]
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      );
                    }),
                    Positioned(
                        bottom: 2,
                        right: chat.own ? null : AppSpacings.xxSmall2,
                        left: chat.own ? AppSpacings.xxSmall2 : null,
                        child: Text(
                          chat.reaction,
                          style: const TextStyle(fontSize: 20),
                        ))
                  ],
                ),
              ),
              if (!chat.own)
                SizedBox(
                  width: _endPadding -
                      (selected ? _selectedIconSize + _selectedIconSpacing : 0),
                ),
              if (chat.own && selected) ...[
                SizedBox(
                  width: _selectedIconSpacing,
                ),
                AppSvgAsset(
                  'assets/images/ic_tick_circle.svg',
                  key: UniqueKey(),
                )
              ]
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
