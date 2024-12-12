import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:info91/firebase_options.dart';

import 'package:sms_autofill/sms_autofill.dart';

import 'src/app.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Handling a background message: ${message.messageId}");
}
FirebaseAnalytics analytics = FirebaseAnalytics.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.instance.subscribeToTopic("all");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //  await FirebaseApi().initNotification();

  SmsAutoFill().listenForCode;
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
runApp(AppWrapper());
}
class AppWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return  MyApp();
      },
    );
  }
}