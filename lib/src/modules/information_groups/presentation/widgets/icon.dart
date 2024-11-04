import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/widgets/custom/image_view.dart';

Widget clickebleIcon(String image,VoidCallback onTap){return InkWell(onTap: onTap,child: AppSvgAsset(image,height: 20.h,fit: BoxFit.fitHeight,),);}