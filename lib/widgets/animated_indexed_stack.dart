import 'package:flutter/material.dart';
import 'package:flutter_tips_and_tricks/widgets/common.dart';

class IndexedAnimatedStack extends StatefulWidget {
  const IndexedAnimatedStack({
    Key? key,
    required this.index,
    required this.children,
  }) : super(key: key);

  final int index;
  final List<WidgetBuilder> children;

  @override
  State<IndexedAnimatedStack> createState() => _IndexedAnimatedStackState();
}

class _IndexedAnimatedStackState extends State<IndexedAnimatedStack> {
  late List<GlobalKey> _keys;
  late final _widgets = <int, Widget>{};
  double _direction = -1.0;
  double _reverseDirection = 1.0;

  @override
  void initState() {
    super.initState();
    _keys = List.generate(
      widget.children.length,
      (index) => GlobalKey(debugLabel: 'page$index'),
    );
  }

  @override
  void didUpdateWidget(covariant IndexedAnimatedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != oldWidget.index) {
      _direction = widget.index > oldWidget.index ? 1.0 : -1.0;
      _reverseDirection = widget.index > oldWidget.index ? -1.0 : 1.0;
    }
    final oldLength = oldWidget.children.length;
    final newLength = widget.children.length;
    if (newLength != oldLength) {
      if (newLength < oldLength) {
        _keys = _keys.sublist(0, newLength);
      } else {
        _keys = [
          ..._keys,
          ...List.generate(
            (newLength - oldLength),
            (index) => GlobalKey(debugLabel: 'page${oldLength + index}'),
          ),
        ];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = _widgets.putIfAbsent(
      widget.index,
      () => widget.children[widget.index](context),
    );
    return Stack(
      fit: StackFit.expand,
      children: [
        for (int i = 0; i < widget.children.length; i++)
          if (i != widget.index)
            _AnimatedPage(
              key: _keys[i],
              visible: false,
              direction: _reverseDirection,
              child: _widgets[i] ?? emptyWidget,
            ),
        _AnimatedPage(
          key: _keys[widget.index],
          visible: true,
          direction: _direction,
          child: current,
        ),
      ],
    );
  }
}

@immutable
class _AnimatedPage extends StatefulWidget {
  const _AnimatedPage({
    super.key,
    required this.visible,
    required this.direction,
    required this.child,
  });

  final bool visible;
  final double direction;
  final Widget child;

  @override
  State<_AnimatedPage> createState() => _AnimatedPageState();
}

class _AnimatedPageState extends State<_AnimatedPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late bool _isOffstage;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
      value: widget.visible ? 1.0 : 0.0,
    );
    _controller.addListener(() {
      isOffstage = _controller.value == 0.0;
    });
    _isOffstage = !widget.visible;
    _updateAnimation();
  }

  set isOffstage(bool value) {
    if (_isOffstage != value) {
      setState(() => _isOffstage = value);
    }
  }

  @override
  void didUpdateWidget(covariant _AnimatedPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateAnimation();
  }

  void _updateAnimation() {
    if (widget.visible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slideInTransition = Tween<Offset>(
      begin: Offset(32.0 * widget.direction, 0.0),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.fastOutSlowIn));
    return FadeTransition(
      opacity: CurveTween(curve: Curves.decelerate).animate(_controller),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.translate(
            offset: widget.visible ? slideInTransition.evaluate(_controller) : Offset.zero,
            child: child,
          );
        },
        child: Offstage(
          offstage: _isOffstage,
          child: IgnorePointer(
            ignoring: _isOffstage,
            child: TickerMode(
              enabled: !_isOffstage,
              child: Material(
                color: Theme.of(context).canvasColor,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
