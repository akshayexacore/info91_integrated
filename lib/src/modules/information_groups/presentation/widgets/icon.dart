import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget clickebleIcon(String image,VoidCallback onTap){return InkWell(onTap: onTap,child: Image.asset(image,height: 20.h,fit: BoxFit.fitHeight,),);}