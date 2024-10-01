import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/custom/app_text_field.dart';
import 'package:info91/src/widgets/custom/reply_chat_message_tile.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class ChatInputWidget extends StatefulWidget {
  const ChatInputWidget({
    Key? key,
    this.onEmojiPressed,
    required this.controller,
    this.focusNode,
    this.onAttachmentsPressed,
    this.showReply = true,
    this.onCloseReply,
    this.replyMessage = '',
  }) : super(key: key);

  final VoidCallback? onEmojiPressed;

  final VoidCallback? onAttachmentsPressed;

  final TextEditingController controller;

  final FocusNode? focusNode;

  final bool showReply;

  final VoidCallback? onCloseReply;

  final String replyMessage;

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  bool isTyped = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: widget.showReply
            ? null
            : [
                BoxShadow(
                  offset: const Offset(7, 0),
                  blurRadius: 7,
                  color: AppColors.black.withOpacity(0.25),
                ),
              ],
      ),
      child: Column(
        children: [
          if (widget.showReply)
            ReplyChatMessageTile(
              onClose: widget.onCloseReply,
              message: widget.replyMessage,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacings.xMedium,
              horizontal: AppPaddings.xSmall10,
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: AppSpacings.small10,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacings.small,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.circular(
                        AppRadii.medium10,
                      ),
                    ),
                    child: AppTextField(
                      focusNode: widget.focusNode,
                      controller: widget.controller,
                      hintText: 'Type your message here',
                      prefix: AppInkWell(
                        onTap: widget.onEmojiPressed,
                        borderRadius: 50,
                        child: const AppSvgAsset(
                          'assets/images/ic_smiley.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      suffix: AppInkWell(
                        onTap: widget.onAttachmentsPressed,
                        borderRadius: 50,
                        child: const AppSvgAsset(
                          'assets/images/ic_attach.svg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      minLines: 1,
                      onChanged: (value) {
                        final typed = value.trim().isNotEmpty;
                        if (typed != isTyped) {
                          setState(() {
                            isTyped = typed;
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: AppSpacings.small10,
                ),
                AppInkWell(
                  borderRadius: 30,
                  /* style: ElevatedButton.styleFrom(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: const CircleBorder(),
                      padding: EdgeInsets.zero,
                      elevation: 0,
                      fixedSize: const Size(30, 30),
                      minimumSize: const Size(0, 0)),*/
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(
                      AppPaddings.xSmall10,
                    ),
                    child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: isTyped
                            ? const SizedBox(
                                key: Key('ic_send'),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: AppSvgAsset(
                                    'assets/images/ic_send.svg',
                                    color: AppColors.primary,
                                  ),
                                ),
                              )
                            : const SizedBox(
                                key: Key('ic_camera'),
                                child: AppSvgAsset(
                                  'assets/images/ic_camera.svg',
                                  color: AppColors.primary,
                                ),
                              )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
