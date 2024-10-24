import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   
  SmsAutoFill().listenForCode;
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    
  ]);
  runApp(  ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true, // Ensure this is set if using split-screen mode
      builder: (context, child) {
        return const App();
      },
    ),);
}
