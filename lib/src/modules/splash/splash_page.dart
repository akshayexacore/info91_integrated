import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Center(
        child: AppAssetImage('assets/images/app_icon.png',width: MediaQuery.of(context).size.width*0.5,),
      ),
    );
  }
}
