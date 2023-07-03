import 'package:flutter/material.dart';
import 'package:flutter_tips_and_tricks/features/main/widgets/app_top_bar.dart';
import 'package:flutter_tips_and_tricks/features/main/widgets/bottom_nav.dart';
import 'package:flutter_tips_and_tricks/features/section_a/section_a.dart';
import 'package:flutter_tips_and_tricks/features/section_b/section_b.dart';
import 'package:flutter_tips_and_tricks/features/section_c/section_c.dart';
import 'package:flutter_tips_and_tricks/features/section_d/section_d.dart';
import 'package:flutter_tips_and_tricks/widgets/animated_indexed_stack.dart';
import 'package:flutter_tips_and_tricks/widgets/show_debug_paint.dart';

@immutable
class MainScreen extends StatefulWidget {
  const MainScreen._();

  static const routeName = '/main';

  static Route<dynamic> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (BuildContext context) {
        return const MainScreen._();
      },
    );
  }

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _sections = <(String, WidgetBuilder)>[
    ('A', (_) => const SectionA()),
    ('B', (_) => const SectionB()),
    ('C', (_) => const SectionC()),
    ('D', (_) => const SectionD()),
  ];
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(),
      body: IndexedAnimatedStack(
        index: _index,
        children: [
          for (final (_, builder) in _sections) //
            builder,
        ],
      ),
      bottomNavigationBar: ShowDebugPaint(
        enabled: false,
        child: BottomNav(
          selected: _index,
          onChanged: (int index) {
            setState(() => _index = index);
          },
          sections: _sections,
        ),
      ),
    );
  }
}
