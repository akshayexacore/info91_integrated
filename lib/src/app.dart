import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/routes/routes.dart';

import 'modules/splash/splash_page.dart';

/// The Widget that configures your application.
class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => 'info91',
      theme: AppThemes.appTheme,
      initialRoute: SplashPage.routeName,
      getPages: Routes.getPages,
    );
  }
}
