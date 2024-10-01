import 'package:flutter/material.dart';
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
            Image.asset("assets/images/bg.jpg", fit: BoxFit.cover),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 1),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Image.asset('assets/images/app_icon.png')),
                const Spacer(flex: 7),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text("In the business of making\ndreams come true.!",
                          style: AppTextStyles.app16B,
                          textAlign: TextAlign.center),
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
