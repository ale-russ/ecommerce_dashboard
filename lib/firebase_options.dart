import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatfrom {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macOs - '
          'you can reconfigure this by running the FlutterFire CLI again',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windws - '
          'you can reconfigure this by running the FlutterFire CLI again',
        );
      default:
        throw UnsupportedError(
            'DefaultFirebaseOptions are not support for this platform');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB2JhRk28MAi4opsz2hHgr3tv7dvijVHQA',
    appId: '1:609444210000:web:6c90239cab40e172c7f855',
    messagingSenderId: '609444210000',
    projectId: 'admin-panel-75fd2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '1:609444210000:android:c83000deb53c816dc7f855',
    appId: '1:609444210000:android:c83000deb53c816dc7f855',
    messagingSenderId: '609444210000',
    projectId: 'admin-panel-75fd2',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD1zev78BwqQjdOkv_JcltudkmoAOD6oCw',
    appId: '1:609444210000:ios:01c0ff066c157152c7f855',
    messagingSenderId: '609444210000',
    projectId: 'admin-panel-75fd2',
  );
}
