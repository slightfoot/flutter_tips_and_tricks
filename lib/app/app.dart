import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show PlatformDispatcher;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show RendererBinding;
import 'package:flutter/services.dart';
import 'package:flutter_tips_and_tricks/app/config.dart';
import 'package:flutter_tips_and_tricks/app/theme.dart';
import 'package:flutter_tips_and_tricks/backend/backend.dart';
import 'package:flutter_tips_and_tricks/features/main/main_screen.dart';
import 'package:flutter_tips_and_tricks/features/splash/splash_screen.dart';
import 'package:flutter_tips_and_tricks/models/user.dart';

@immutable
class FlutterTipsApp extends StatefulWidget {
  const FlutterTipsApp({
    super.key,
    required this.config,
  });

  final AppConfig config;

  @override
  State<FlutterTipsApp> createState() => _FlutterTipsAppState();
}

class _FlutterTipsAppState extends State<FlutterTipsApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  Future<void>? _splashLoader;
  Future<void>? _appLoader;
  Backend? _backend;

  @override
  void initState() {
    super.initState();
    RendererBinding.instance.deferFirstFrame();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _splashLoader ??= _loadSplash(context).whenComplete(
      () => RendererBinding.instance.allowFirstFrame(),
    );
    _appLoader ??= _loadApp(context).whenComplete((){
      if(mounted) {
        _navigatorKey.currentState!.pushReplacementNamed(MainScreen.routeName);
      }
    });
  }

  Future<void> _loadSplash(BuildContext context) async {
    await SplashScreen.precacheAssets(context);
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // await SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
  }

  Future<void> _loadApp(BuildContext context) async {
    await Firebase.initializeApp(options: widget.config.firebaseOptions);
    if (widget.config.env == AppEnv.prod) {
      // Pass all uncaught "fatal" errors from the framework to Crashlytics
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
      // Pass all uncaught asynchronous errors that aren't handled to Crashlytics
      PlatformDispatcher.instance.onError = (Object error, StackTrace stackTrace) {
        FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
        return true;
      };
    }
    _backend = await Backend.init();
    // Delayed for demonstration purposes
    // await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _backend?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: appOverlayStyle,
      child: FutureBuilder<void>(
        future: _appLoader,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Tips and Tricks',
            theme: appTheme,
            navigatorKey: _navigatorKey,
            onGenerateRoute: (RouteSettings settings) {
              return switch (settings.name) {
                SplashScreen.routeName => SplashScreen.route(),
                MainScreen.routeName => MainScreen.route(),
                _ => null,
              };
            },
            showSemanticsDebugger: false,
          );
        },
      ),
    );
  }
}
