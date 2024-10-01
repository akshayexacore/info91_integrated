import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    Key? key,
    this.onPressed,
    this.showBackGround = true,
    this.color = AppColors.hint,
  }) : super(key: key);
  final VoidCallback? onPressed;

  final size = AppSizes.appBackButton;
  final bool showBackGround;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      borderRadius: 30,
      onTap: onPressed,
      child: SizedBox(
        height: 30,
        width: 30,
        child: Center(
          child: AppSvgAsset(
            'assets/images/arrow_back.svg',
            color: color,
          ),
        ),
      ),
    );
  }
}
