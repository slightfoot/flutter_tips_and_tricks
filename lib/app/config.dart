import 'package:firebase_core/firebase_core.dart';

enum AppEnv {
  dev,
  prod;
}

class AppConfig {
  const AppConfig({
    required this.env,
    required this.firebaseOptions,
  });

  final AppEnv env;
  final FirebaseOptions firebaseOptions;
}
