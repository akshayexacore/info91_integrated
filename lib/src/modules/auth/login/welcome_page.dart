import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';

import 'controllers/login_controller.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key}) : super(key: key);

  static const routeName = '/welcome';

  final _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Stack(
          fit: StackFit.expand,
          children: [
           
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 10),
                // SizedBox(
                //     width: MediaQuery.of(context).size.width * 0.45,
                //     child: Image.asset('assets/images/app_icon.png')),
                 Center(
                child:
                    Image.asset("assets/images/start.png", fit: BoxFit.cover)),
                const Spacer(flex: 7),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Connect & Collaborate",
                          style: AppTextStyles.app16B.copyWith(fontSize: 23.sp),
                          textAlign: TextAlign.center),
                      Text("Dive Into Conversations and Groups!",
                          style: AppTextStyles.app16B.copyWith(
                              fontSize: 22.sp,
                              color: AppColors.text,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.left),
                      const SizedBox(
                        height: AppSpacings.xxLarge,
                      ),
                      AppButton(
                          text: "Let’s Start",
                          onPressed: _loginController.gotoLoginPage),
                    ],
                  ),
                ),
                const Spacer(
                  flex: 1,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
