import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef WidgetChildBuilder = Widget Function(BuildContext context, Widget child);

@immutable
class ChildBuilder extends StatelessWidget {
  const ChildBuilder({
    super.key,
    required this.builder,
    required this.child,
  });

  final WidgetChildBuilder builder;
  final Widget child;

  @override
  Widget build(BuildContext context) => builder(context, child);
}
