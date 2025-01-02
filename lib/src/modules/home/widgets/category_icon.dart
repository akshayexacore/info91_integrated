import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class CategoryIcon extends StatelessWidget {
  const CategoryIcon({
    super.key,
    required this.assetIcon,
    required this.title,
    this.onPressed, this.clr,
  });

  final String assetIcon;
  final String title;final Color? clr;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AppInkWell(
            onTap: onPressed,
            borderRadius: 100,
            child: Container(
              height: 60.h,
              width: 60.w,
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: const Offset(2, 2))
                  ]),
              child: Center(
                child: AppSvgAsset(
                  'assets/images/$assetIcon',
                  width: 35.w,
                  height: 35.h,color: clr??null,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: AppSpacings.xSmall,
          ),
          Text(
            textAlign: TextAlign.center,
            title,
            maxLines: 2,
            style: const TextStyle(
              fontSize: AppFontSizes.xxSmall,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }
}
