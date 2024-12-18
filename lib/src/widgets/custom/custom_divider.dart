import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';


Padding customDivider({EdgeInsets? padding, double? thickness,Color? clr}) {
  return Padding(
      padding: padding ??
          EdgeInsets.only(left: 80.0.w), // Adjust this value for more space
      child: Divider(
        color:clr?? AppColors.white, // Color of the divider
        thickness: thickness ?? .6, // Thickness of the divider
      ));
}
