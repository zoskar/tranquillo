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
    apiKey: 'AIzaSyBxnb8DOg94_tknGof-lQ83Rap3VZQjans',
    appId: '1:1013999627334:android:99ddbaa18a304d3fca6e47',
    messagingSenderId: '1013999627334',
    projectId: 'dictando-78c79',
    databaseURL:
        'https://dictando-78c79-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'dictando-78c79.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAp6q4GdakXH8PXCDkfFca0qJJollb2Bk4',
    appId: '1:1013999627334:ios:1c2137826d8f19d2ca6e47',
    messagingSenderId: '1013999627334',
    projectId: 'dictando-78c79',
    databaseURL:
        'https://dictando-78c79-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'dictando-78c79.appspot.com',
    iosClientId:
        '1013999627334-g8ibd5vg10pur06gm0rj7jd3e531javv.apps.googleusercontent.com',
    iosBundleId: 'com.example.tranquillo',
  );
}
