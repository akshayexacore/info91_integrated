import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';

class AppInkWell extends StatelessWidget {
  const AppInkWell({
    Key? key,
    this.child,
    this.borderRadius = 0,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  final Widget? child;

  final double borderRadius;

  final VoidCallback? onTap;

  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child ?? const SizedBox(),
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  highlightColor: AppColors.offWhite.withOpacity(0.1),
                  onLongPress: onLongPress,
                  child: const SizedBox(),
                )),
          ),
        )
      ],
    );
  }
}
