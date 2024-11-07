import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/informationgroup/chat_model.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/chat_screen/info_group_chat_screen.dart';

import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class ReplyChatMessageTile extends StatelessWidget {
  const ReplyChatMessageTile({
    super.key,
    this.onClose,
    this.isChatMessage = false,
    required this.message,
    this.chatMessage,
  });

  final String message;
  final bool isChatMessage;
  final ChatMessage? chatMessage;

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       Text(
                      chatMessage?.name??"",
                        style: TextStyle(
                          fontSize: AppFontSizes.small15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isChatMessage) ...[
                        if (chatMessage!.type == MessageType.image)
                          _imageDesign(),
                        if (chatMessage!.type == MessageType.text)
                          textMsaageType(),
                        if (chatMessage!.type == MessageType.document)
                          textMsaageType(),
                      ] else ...[
                        textMsaageType(),
                      ]
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

  Widget textMsaageType() {
    return SizedBox(
      width: 300.w,
      child: Text(
        message,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontSize: AppFontSizes.small,
        ),
      ),
    );
  }

  Row _imageDesign() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.image,
          size: 27.sp,
        ),
        SizedBox(
          width: 2.w,
        ),
        Text(
          "Photo",
          style: TextStyle(
            fontSize: AppFontSizes.small,
          ),
        ),
        Expanded(child: Container()),
        imageErrorHandling(chatMessage?.message ?? ""),
      ],
    );
  }

  Row _docDesign() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.document_scanner,
          size: 27.sp,
        ),
        SizedBox(
          width: 2.w,
        ),
        const Text(
          "document name",
          style: TextStyle(
            fontSize: AppFontSizes.small,
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Image imageErrorHandling(String imageUrl) {
    return Image.network(
      imageUrl ?? "",
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // Return default widget or image when the URL fails
        return Icon(
          Icons.image,
          size: 27.sp,
        );
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes!)
                : null,
          ),
        );
      },
    );
  }
}
