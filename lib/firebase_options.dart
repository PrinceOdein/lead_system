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
    apiKey: 'AIzaSyCbgPl2xhvOOp79k6uQZqgN5dI_O3AP-0w',
    appId: '1:356384541578:web:b05bce3bd9b3b098f51673',
    messagingSenderId: '356384541578',
    projectId: 'leadsystem-tmndn18',
    authDomain: 'leadsystem-tmndn18.firebaseapp.com',
    storageBucket: 'leadsystem-tmndn18.firebasestorage.app',
    measurementId: 'G-Z4DQK076TF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFmwuovUOcyL6qOqQ5AAZlTP_NcUfnGmM',
    appId: '1:356384541578:android:99d38f47044357ebf51673',
    messagingSenderId: '356384541578',
    projectId: 'leadsystem-tmndn18',
    storageBucket: 'leadsystem-tmndn18.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAfx1GqbOLmlnldEx-lVS_k_q1PjzHUxoY',
    appId: '1:356384541578:ios:671f9c942e26bba9f51673',
    messagingSenderId: '356384541578',
    projectId: 'leadsystem-tmndn18',
    storageBucket: 'leadsystem-tmndn18.firebasestorage.app',
    iosBundleId: 'com.example.leadSystem',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAfx1GqbOLmlnldEx-lVS_k_q1PjzHUxoY',
    appId: '1:356384541578:ios:671f9c942e26bba9f51673',
    messagingSenderId: '356384541578',
    projectId: 'leadsystem-tmndn18',
    storageBucket: 'leadsystem-tmndn18.firebasestorage.app',
    iosBundleId: 'com.example.leadSystem',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCbgPl2xhvOOp79k6uQZqgN5dI_O3AP-0w',
    appId: '1:356384541578:web:af5cc2ac32f47710f51673',
    messagingSenderId: '356384541578',
    projectId: 'leadsystem-tmndn18',
    authDomain: 'leadsystem-tmndn18.firebaseapp.com',
    storageBucket: 'leadsystem-tmndn18.firebasestorage.app',
    measurementId: 'G-N0P8KVWE9X',
  );
}
