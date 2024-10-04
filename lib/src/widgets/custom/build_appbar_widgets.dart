  import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/custom/image_view.dart';

Widget buildOption(
    String s, {
    VoidCallback? onPressed,
  }) {
    return AppInkWell(
      borderRadius: 24,
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(
          AppPaddings.small / 2,
        ),
        child: SizedBox(
            height: 24,
            width: 24,
            child: Center(
                child: AppSvgAsset(
              'assets/images/$s',
              color: AppColors.white,
            ))),
      ),
    );
  }