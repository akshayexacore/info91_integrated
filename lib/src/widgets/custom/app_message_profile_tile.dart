import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/chat.dart';
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

class AppAlarmProfileTile extends StatelessWidget {
  const AppAlarmProfileTile({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.isButton = false,
    this.onButtonPressed,
    this.selected,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    this.leading,
    this.messageStatus,
    this.color,
  });

  final VoidCallback? onPressed;
  final String imageUrl;
  final String title;
  final String subTitle;
  final String? leading;
  final bool isButton;
  final MessageStatus? messageStatus;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onLongPress;
  final Color? color;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: onPressed,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
          color: selected != null && selected!
            ? AppColors.primary.withOpacity(0.1)
            : color ?? null,borderRadius: BorderRadius.circular(15.r)
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppPaddings.small,horizontal: AppPaddings.small
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppCircleImage(
              image: imageUrl,
              radius: 24,
            ),
            const SizedBox(
              width: 14,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
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
                      if (leading != null)
                        AppMessageStatus(
                          messageStatus: messageStatus ?? MessageStatus.none,
                          time: leading!,
                        )
                    ],
                  ),
                  SizedBox(
                    width: 150.w,
                    child: Text(
                      subTitle,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 14, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // const Divider(
                  //   height: 1,
                  //   color: AppColors.white,
                  // ),
                ],
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            if (leading == null)
              isButton
                  ? InkWell(
                      onTap: onButtonPressed,
                      child: Container(
                        width: 110.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xffE32727).withOpacity(.2)),
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            "Stop alarm",
                            style: GoogleFonts.poppins(
                                color: AppColors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 11.sp),
                          ),
                        ),
                      ),
                    )
                  : AppCheckBox(value: selected ?? false)
          ],
        ),
      ),
    );
  }
}
