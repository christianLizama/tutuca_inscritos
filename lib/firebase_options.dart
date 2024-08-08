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
    apiKey: 'AIzaSyCaEepaO-3aZ6p9uYlMhiMP0pywuuHFcNg',
    appId: '1:227803171140:web:f398dca5cc571dca0d2f11',
    messagingSenderId: '227803171140',
    projectId: 'tutuca-inscritos',
    authDomain: 'tutuca-inscritos.firebaseapp.com',
    storageBucket: 'tutuca-inscritos.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3oNO-qfbcRyIQra0pkaxAqn3EmB7EOrc',
    appId: '1:227803171140:android:250eefc0b5d2a29e0d2f11',
    messagingSenderId: '227803171140',
    projectId: 'tutuca-inscritos',
    storageBucket: 'tutuca-inscritos.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAyQii--3uOiaVCdhDvUiHdLZx2jZYWZVI',
    appId: '1:227803171140:ios:6379b9a3c43f5b010d2f11',
    messagingSenderId: '227803171140',
    projectId: 'tutuca-inscritos',
    storageBucket: 'tutuca-inscritos.appspot.com',
    iosBundleId: 'com.example.tutucaInscritos',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAyQii--3uOiaVCdhDvUiHdLZx2jZYWZVI',
    appId: '1:227803171140:ios:6379b9a3c43f5b010d2f11',
    messagingSenderId: '227803171140',
    projectId: 'tutuca-inscritos',
    storageBucket: 'tutuca-inscritos.appspot.com',
    iosBundleId: 'com.example.tutucaInscritos',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCaEepaO-3aZ6p9uYlMhiMP0pywuuHFcNg',
    appId: '1:227803171140:web:eb81e99aa6529fbe0d2f11',
    messagingSenderId: '227803171140',
    projectId: 'tutuca-inscritos',
    authDomain: 'tutuca-inscritos.firebaseapp.com',
    storageBucket: 'tutuca-inscritos.appspot.com',
  );
}
