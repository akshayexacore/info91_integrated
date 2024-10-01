import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class AppCheckBox extends StatelessWidget {
  const AppCheckBox({
    super.key,
    required this.value,
    this.onChanged,
    this.size = 22,
  });

  final bool value;

  final VoidCallback? onChanged;

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: AppInkWell(
        onTap: onChanged,
        borderRadius: size,
        child: value
            ? AppSvgAsset(
                'assets/images/ic_tick_circle.svg',
                key: UniqueKey(),
              )
            : Container(
                decoration: const BoxDecoration(
                    color: AppColors.unSelected,
                    borderRadius: BorderRadius.all(Radius.circular(22))),
              ),
      ),
    );
  }
}
