import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/resources/shared_preferences_data_provider.dart';
import 'package:info91/src/resources/user_profile_repository.dart';
import 'package:info91/src/widgets/custom/app_circle_image.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   debugPrint("Handling a background message: ${message.messageId}");
// }

class FirebaseApi {
  final BuildContext context;

  FirebaseApi(this.context);
  static String? fcmToken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
 late final _preferences = SharedPreferencesDataProvider();
  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    debugPrint("Permission requested");

    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    debugPrint("Auto-init enabled");

   fcmToken = await _firebaseMessaging.getToken();
    debugPrint("FCM token: $fcmToken");

_preferences.saveFcmToken(fcmToken??"");
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint("User granted permission: ${settings.authorizationStatus}");

    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    debugPrint("Background message handler set");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Foreground Notification: ${message.notification?.title}");
      if (message.notification != null) {
        debugPrint("Foreground Notification: ${message.notification?.title}");
        // showPopup(context, message.notification?.title ?? "", message.notification?.body ?? "");
        showPopup( message.notification?.title ?? "", message.notification?.body ?? "");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("Notification clicked: ${message.data}");
      // showPopup(context, message.notification?.title ?? "", message.notification?.body ?? "");
      showPopup(message.notification?.title ?? "", message.notification?.body ?? "");
    });
  }




// void showPopup(BuildContext context, String title, String body) {
//   OverlayEntry overlayEntry = OverlayEntry(
//     builder: (context) => Positioned(
//       top: 50, // Adjust the position as needed
//       left: 10,
//       right: 10,
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           width: MediaQuery.of(context).size.width - 20,
//           padding: const EdgeInsets.all(10.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 10,
//                 spreadRadius: 1,
//                 offset: Offset(0, 5),
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                circleAssetimage("assets/images/app_new_icon.png"),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Text(
//                       "info91",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14.sp,
//                         color: AppColors.text
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),Text(
//                       "now",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14.sp,
//                         color: AppColors.text
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                      Icon( Icons.notifications, color: Colors.grey, size: 13.sp,),
//                 ],
//               ),
//             const  SizedBox(height: 10),
//               Text(
//                 body,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black54,
//                 ),
//               ),
//               // SizedBox(height: 10),
//               // Align(
//               //   alignment: Alignment.bottomRight,
//               //   child: TextButton(
//               //     onPressed: () {
//               //       // overlayEntry.remove();
//               //     },
//               //     child:const Text(
//               //       "OK",
//               //       style: TextStyle(
//               //         color: AppColors.primary,
//               //         fontWeight: FontWeight.bold,
//               //       ),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );

//   Overlay.of(context)?.insert(overlayEntry);

//   // Automatically remove the popup after a certain duration
//   Future.delayed(Duration(seconds: 2), () {
//     overlayEntry.remove();
//   });
// }


 void showPopup(String title, String body) {
  Get.dialog(
    Align(
      alignment: Alignment.topCenter,
      child: Material(
        color: Colors.transparent,
        child: Container(
          // margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Replace this with your custom circle asset image function
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage("assets/images/app_new_icon.png"),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "info91",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: AppColors.text,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: AppColors.text,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Icon(
                    Icons.notifications,
                    color: Colors.grey,
                    size: 13.sp,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false, // Prevent dismissal by tapping outside
  );

  // Automatically dismiss the dialog after 2 seconds
  Future.delayed(const Duration(seconds: 2), () {
    if (Get.isDialogOpen == true) {
      Get.back(); // Close the dialog
    }
  });
}



}


