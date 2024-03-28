// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1LfsEnaCxEwSmhldOs0rLZES7eLjdjko',
    appId: '1:772501374258:android:fd249455bee5027516032b',
    messagingSenderId: '772501374258',
    projectId: 'payback-cd6da',
    databaseURL: 'https://payback-cd6da-default-rtdb.firebaseio.com',
    storageBucket: 'payback-cd6da.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBX-_qIiToBcjvQxNURyyCbq-5dZSnCYZ8',
    appId: '1:772501374258:ios:f7cabf47868c7a4116032b',
    messagingSenderId: '772501374258',
    projectId: 'payback-cd6da',
    databaseURL: 'https://payback-cd6da-default-rtdb.firebaseio.com',
    storageBucket: 'payback-cd6da.appspot.com',
    androidClientId: '772501374258-f2hfqqa5jm6ra2r3qfsq61fsoqc1v838.apps.googleusercontent.com',
    iosClientId: '772501374258-5qfspjfrcl851j91d8aom7o5l0ki2k97.apps.googleusercontent.com',
    iosBundleId: 'com.example.payback',
  );
}