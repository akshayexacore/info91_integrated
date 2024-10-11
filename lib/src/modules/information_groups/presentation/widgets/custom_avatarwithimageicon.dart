import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';

class ReusableAvatarWithIcon extends StatelessWidget {
  final ImageProvider profileImage;
  final double radius;
  final bool showIcon;
  final Widget? iconWidget;

  final Alignment iconAlignment;

  const ReusableAvatarWithIcon({
    required this.profileImage,
    this.radius = 35.0,
    this.showIcon = false,
    this.iconWidget,
    this.iconAlignment = Alignment.bottomRight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: radius - 4.0, // Adjust to create a border effect
            backgroundImage: profileImage,
          ),
        ),
        if (showIcon && iconWidget != null) iconWidget!,
      ],
    );
  }
}

class CustomCircleIconWidget extends StatelessWidget {
  final VoidCallback onCange;
  final Color backgroundClr;
  final Widget? centerWidget;
  final IconData iconData;
  final double radius;
  final Color iconColor;
  final VoidCallback? onLongPress;
  final VoidCallback? onLongPressEnd;
  final double iconSize;
  const CustomCircleIconWidget(
      {super.key,
      this.iconColor = AppColors.white,
      required this.onCange,
      this.radius = 12.5,
      this.iconSize = 15,
      this.backgroundClr = AppColors.secondary,
      this.centerWidget,
      this.iconData = Icons.check,
      this.onLongPress,
      this.onLongPressEnd});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onCange,
        onLongPress: onLongPress,
        onLongPressEnd: (va) {
          onLongPressEnd!();
        },
        child: CircleAvatar(
          backgroundColor: backgroundClr,
          radius: radius,
          child: centerWidget != null
              ? centerWidget
              : Center(
                  child: Icon(
                  iconData,
                  color: iconColor,
                  size: iconSize.sp,
                )),
        ));
  }
}
