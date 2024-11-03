import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/splash/controllers/splash_controller.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  static const routeName = '/';

  final SplashController splashController = Get.find();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppAssetImage('assets/images/app_icon.png',width: MediaQuery.of(context).size.width*0.5,),
            SizedBox(height: 12.h,),
            Text("Lets Connect India",style: GoogleFonts.poppins(color: AppColors.primary,fontSize: 26.sp,fontWeight: FontWeight.w600),)
          ],
        ),
      ),
    );
  }
}
