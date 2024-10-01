import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: AppSizes.logoHeight,
      width: AppSizes.logoWidth,
      child: AppAssetImage('assets/images/logo.png'),
    );
  }
}
