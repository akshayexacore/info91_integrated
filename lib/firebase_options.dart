// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBVgX3SX5ii7U7zFS7FbVOXIdUx9ZiCD6w',
    appId: '1:257511807190:web:26e35676e896f0094a5177',
    messagingSenderId: '257511807190',
    projectId: 'info91-7ab79',
    authDomain: 'info91-7ab79.firebaseapp.com',
    storageBucket: 'info91-7ab79.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDpXx_yCii7ARFddt4l3vFJwHNKiXg5FYc',
    appId: '1:257511807190:android:bb58e80fca98cd204a5177',
    messagingSenderId: '257511807190',
    projectId: 'info91-7ab79',
    storageBucket: 'info91-7ab79.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAvZ6x_8SUgm3M_DiadMoyjip9a5lk7Wlw',
    appId: '1:257511807190:ios:93c9254e6951c40e4a5177',
    messagingSenderId: '257511807190',
    projectId: 'info91-7ab79',
    storageBucket: 'info91-7ab79.firebasestorage.app',
    iosBundleId: 'com.example.info91Completed',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAvZ6x_8SUgm3M_DiadMoyjip9a5lk7Wlw',
    appId: '1:257511807190:ios:93c9254e6951c40e4a5177',
    messagingSenderId: '257511807190',
    projectId: 'info91-7ab79',
    storageBucket: 'info91-7ab79.firebasestorage.app',
    iosBundleId: 'com.example.info91Completed',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBVgX3SX5ii7U7zFS7FbVOXIdUx9ZiCD6w',
    appId: '1:257511807190:web:26e35676e896f0094a5177',
    messagingSenderId: '257511807190',
    projectId: 'info91-7ab79',
    authDomain: 'info91-7ab79.firebaseapp.com',
    storageBucket: 'info91-7ab79.firebasestorage.app',
  );
}
