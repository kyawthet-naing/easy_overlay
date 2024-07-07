import 'package:flutter/material.dart';
import 'widgets/overlay_widget.dart';

class EasyOverlayCtx {
  static OverlayEntry? _overlay;

  static void show(
    BuildContext context, {
    Color barrierColor = Colors.black54,
    Widget? child,
    Color color = Colors.black38,
    bool barrierDismissible = true,
  }) {
    if (_overlay != null) return;
    _overlay = OverlayEntry(
      builder: (BuildContext context) {
        return OverlayWidget(
          onTap: barrierDismissible ? EasyOverlayCtx.dismiss : null,
          barrierDismissible: barrierDismissible,
          barrierColor: barrierColor,
          child: child,
        );
      },
    );
    Overlay.of(context).insert(_overlay!);
  }

  static void dismiss() {
    if (_overlay == null) return;
    _overlay!.remove();
    _overlay = null;
  }
}
