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

    ///TODO SET UP OWN FIREBASE PROJECT
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '',
    appId: '1:1038862380479:android:d67d410cd56663f9ff050a',
    messagingSenderId: '1038862380479',
    projectId: 'arfurniture-ad41c',
    storageBucket: 'arfurniture-ad41c.appspot.com',
  );

    ///TODO SET UP OWN FIREBASE PROJECT
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '1:1038862380479:ios:35c48a57ef2279ebff050a',
    messagingSenderId: '1038862380479',
    projectId: 'arfurniture-ad41c',
    storageBucket: 'arfurniture-ad41c.appspot.com',
    iosClientId: '1038862380479-6ia1p8futfgav3ubfp4102tsdmojjq4t.apps.googleusercontent.com',
    iosBundleId: 'com.aroutdoorfurniture.arOutdoorFurniture',
  );
}
