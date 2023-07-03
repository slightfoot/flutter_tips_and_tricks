import 'package:flutter/material.dart';
import 'package:flutter_tips_and_tricks/app/app.dart';
import 'package:flutter_tips_and_tricks/app/config.dart';
import 'package:flutter_tips_and_tricks/firebase_options.dart';

// Before running please read: README.md

void main() {
  runApp(
    FlutterTipsApp(
      config: AppConfig(
        env: AppEnv.dev,
        firebaseOptions: DefaultFirebaseOptions.currentPlatform,
      ),
    ),
  );
}
