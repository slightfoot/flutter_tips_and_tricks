import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ShowDebugPaint extends SingleChildRenderObjectWidget {
  const ShowDebugPaint({
    Key? key,
    this.enabled = true,
    required Widget child,
  }) : super(key: key, child: child);

  final bool enabled;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderShowDebugPaint(enabled: enabled);
  }

  @override
  void updateRenderObject(BuildContext context, RenderShowDebugPaint renderObject) {
    renderObject.enabled = enabled;
  }
}

class RenderShowDebugPaint extends RenderProxyBox {
  RenderShowDebugPaint({required bool enabled, RenderBox? child})
      : _enabled = enabled, super(child);

  bool _enabled;
  bool get enabled => _enabled;

  set enabled(bool value) {
    if (_enabled != value) {
      _enabled = value;
      markNeedsPaint();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final previousState = debugPaintSizeEnabled;
    debugPaintSizeEnabled = enabled;
    super.paint(context, offset);
    debugPaintSizeEnabled = previousState;
  }
}
