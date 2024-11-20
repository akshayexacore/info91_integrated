import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/custom/image_view.dart';

class ComingSoonPage extends StatelessWidget {
  final String appBarName;
   final String content;

  const ComingSoonPage({super.key, required this.appBarName, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(appBarName: appBarName),
          Expanded(
              child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 20.w, vertical: 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                // color: Colors.red,
                child: const Center(
                  child: AppSvgAsset(
                    'assets/images/coming_soon.svg',
                    width: 100,
                    height: 110,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              greynonBoldText("Exciting new Feature",size: 24.sp,color: AppColors.text),
               SizedBox(height: 15.h,),
              greynonBoldText("Coming \nSoon!",size: 48.sp,color: AppColors.secondary,fontWeight: FontWeight.bold,height: 1),
              SizedBox(height: 30.h,),
             
              greynonBoldText(content,size:15.sp )
            ]),
          ))
        ],
      ),
    );
  }
}
