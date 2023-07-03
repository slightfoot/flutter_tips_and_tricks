import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: appLightTheme.appColor0,
  ),
  useMaterial3: true,
  extensions: const [
    appLightTheme,
  ],
);

const appLightTheme = AppTheme(
  appColor0: Color(0xFF0D26DE),
  appColor1: Color(0xFF1FB7F8),
  appColor2: Color(0xFFE0E0F0),
);

const appOverlayStyle = SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
  statusBarIconBrightness: Brightness.light,
  systemNavigationBarColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.light,
);

class AppTheme extends ThemeExtension<AppTheme> {
  const AppTheme({
    required this.appColor0,
    required this.appColor1,
    required this.appColor2,
  });

  final Color appColor0;
  final Color appColor1;
  final Color appColor2;

  static AppTheme of(BuildContext context) {
    return Theme.of(context).extension<AppTheme>()!;
  }

  @override
  ThemeExtension<AppTheme> copyWith({
    Color? appColor0,
    Color? appColor1,
    Color? appColor2,
  }) {
    return AppTheme(
      appColor0: appColor0 ?? this.appColor0,
      appColor1: appColor1 ?? this.appColor1,
      appColor2: appColor2 ?? this.appColor2,
    );
  }

  @override
  ThemeExtension<AppTheme> lerp(covariant AppTheme other, double t) {
    return AppTheme(
      appColor0: Color.lerp(appColor0, other.appColor0, t)!,
      appColor1: Color.lerp(appColor1, other.appColor1, t)!,
      appColor2: Color.lerp(appColor2, other.appColor2, t)!,
    );
  }
}
