import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/configs/firebase.dart';
import 'package:info91/src/routes/routes.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'modules/splash/splash_page.dart';
FirebaseAnalytics analytics = FirebaseAnalytics.instance;
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    
    data();
  }

  Future<void> data() async {
    await FirebaseApi(context).initNotification();
    
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
   
        return GlobalLoaderOverlay(
          useDefaultLoading: false,
          disableBackButton: true,
          closeOnBackButton: false,
          overlayWholeScreen: true,
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (BuildContext context) => 'info91',
            theme: AppThemes.appTheme,
            initialRoute: SplashPage.routeName,
            getPages: Routes.getPages,
            navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
          ),
        );
   
  }
}
