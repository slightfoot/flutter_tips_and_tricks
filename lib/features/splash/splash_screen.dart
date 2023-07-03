import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tips_and_tricks/app/assets.dart';
import 'package:flutter_tips_and_tricks/app/theme.dart';
import 'package:flutter_tips_and_tricks/widgets/common.dart';

@immutable
class SplashScreen extends StatelessWidget {
  const SplashScreen._();

  static Future<void> precacheAssets(BuildContext context) async {
    const loader = SvgAssetLoader(ImageAssets.logo);
    svg.cache.putIfAbsent(loader.cacheKey(context), () => loader.loadBytes(null));
  }

  static const routeName = Navigator.defaultRouteName;

  static Route<dynamic> route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(
          opacity: TrainHoppingAnimation(animation, secondaryAnimation),
          child: const SplashScreen._(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final modalRoute = ModalRoute.of(context);
    return Material(
      color: AppTheme.of(context).appColor1,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              ImageAssets.logo,
              width: 288.0,
            ),
            Align(
              alignment: Alignment.topCenter,
              heightFactor: 0.0,
              child: Padding(
                padding: verticalPadding24,
                child: FadeTransition(
                  opacity: modalRoute!.animation!,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
