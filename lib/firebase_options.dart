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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB2JhRk28MAi4opsz2hHgr3tv7dvijVHQA',
    appId: '1:609444210000:web:7a1e3f6d7bfea16fc7f855',
    messagingSenderId: '609444210000',
    projectId: 'admin-panel-75fd2',
    authDomain: 'admin-panel-75fd2.firebaseapp.com',
    storageBucket: 'admin-panel-75fd2.appspot.com',
    measurementId: 'G-LM16GEYEY9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAUiSFamctq9Yp2782LVswfmDoohDyme8I',
    appId: '1:609444210000:android:e2ec6605fd140f8bc7f855',
    messagingSenderId: '609444210000',
    projectId: 'admin-panel-75fd2',
    storageBucket: 'admin-panel-75fd2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD1zev78BwqQjdOkv_JcltudkmoAOD6oCw',
    appId: '1:609444210000:ios:663f288838d354fdc7f855',
    messagingSenderId: '609444210000',
    projectId: 'admin-panel-75fd2',
    storageBucket: 'admin-panel-75fd2.appspot.com',
    androidClientId: '609444210000-5d104k3a7ke891kbirpgfn3s33qvbtbf.apps.googleusercontent.com',
    iosClientId: '609444210000-rr2js68rr32ofpvbojjoaqtn7goovo4f.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecommerceDashboard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD1zev78BwqQjdOkv_JcltudkmoAOD6oCw',
    appId: '1:609444210000:ios:663f288838d354fdc7f855',
    messagingSenderId: '609444210000',
    projectId: 'admin-panel-75fd2',
    storageBucket: 'admin-panel-75fd2.appspot.com',
    androidClientId: '609444210000-5d104k3a7ke891kbirpgfn3s33qvbtbf.apps.googleusercontent.com',
    iosClientId: '609444210000-rr2js68rr32ofpvbojjoaqtn7goovo4f.apps.googleusercontent.com',
    iosBundleId: 'com.example.ecommerceDashboard',
  );
}
