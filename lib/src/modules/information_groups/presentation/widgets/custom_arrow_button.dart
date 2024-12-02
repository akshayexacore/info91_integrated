import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';

class CustomArrowTextbutton extends StatelessWidget {
  final String buttonName;
  final String? toptitle;
  final VoidCallback onTap;
  final IconData? icon;
  const CustomArrowTextbutton(
      {super.key,
      required this.buttonName,
      this.toptitle,
      required this.onTap,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (toptitle != null) ...[
          greyBoldText(toptitle!),
          SizedBox(
            height: 10.h,
          )
        ],
        InkWell(
          onTap: onTap,
          child: Container(
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                  color: AppColors.dividerlight,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Text(
                    buttonName,
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xff5F6368),
                    size: 17.sp,
                  )
                ],
              )),
        ),
      ],
    );
  }
}
