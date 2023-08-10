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
    apiKey: 'AIzaSyAZTvXZjKh6SnYr3bLsKR0L138DdURTsZg',
    appId: '1:833227821476:web:0f45a6b2f3d379b049b131',
    messagingSenderId: '833227821476',
    projectId: 'note-45c4b',
    authDomain: 'note-45c4b.firebaseapp.com',
    storageBucket: 'note-45c4b.appspot.com',
    measurementId: 'G-RX9WLE3NF9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCW6s99nnMEFoS0j9rkufcLxemqqt43g7M',
    appId: '1:833227821476:android:ebc00cf24f43f0f049b131',
    messagingSenderId: '833227821476',
    projectId: 'note-45c4b',
    storageBucket: 'note-45c4b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAlf3fnqX3bI-WgHx63hHYBfMFiW-eNM3A',
    appId: '1:833227821476:ios:b38dd5e825a4326649b131',
    messagingSenderId: '833227821476',
    projectId: 'note-45c4b',
    storageBucket: 'note-45c4b.appspot.com',
    iosClientId: '833227821476-c0f1kompi4vtca5r25jp08chifp60nfn.apps.googleusercontent.com',
    iosBundleId: 'com.example.noteApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAlf3fnqX3bI-WgHx63hHYBfMFiW-eNM3A',
    appId: '1:833227821476:ios:3f10c0f5ec1e426549b131',
    messagingSenderId: '833227821476',
    projectId: 'note-45c4b',
    storageBucket: 'note-45c4b.appspot.com',
    iosClientId: '833227821476-878viv9qlo3pakloubmslf1ejh8gjvsd.apps.googleusercontent.com',
    iosBundleId: 'com.example.noteApp.RunnerTests',
  );
}
