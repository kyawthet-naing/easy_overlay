import 'package:flutter/material.dart';
import '/easy_overlay.dart';

class EasyOverlayCtx {
  static OverlayEntry? _overlay;
  static OverlayEntry? _toastEntry;

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
    _overlay?.remove();
    _overlay = null;
  }

  // Hides the currently displayed toast
  static void _dismissToast() {
    _toastEntry?.remove();
    _toastEntry = null;
  }

  // Shows a toast message with a chosen animation
  static void showToast(
    BuildContext context, {
    String? message,
    Widget? child,
    bool reverseAnimation = true,
    Alignment alignment = Alignment.center,
    Duration duration = const Duration(seconds: 2),
    Duration animationDuration = const Duration(milliseconds: 300),
    AnimationType animationType = AnimationType.slideUp,
    ToastDecoration? decoration,
  }) {
    assert(
      child != null || message != null,
      'Either child or message must be provided.',
    );

    // Dismiss any existing toast before showing a new one
    _dismissToast();

    _toastEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Align(
          alignment: alignment,
          child: ToastOverlay(
            message: message,
            duration: duration,
            dimissOverlay: _dismissToast,
            animationType: animationType,
            reverseAnimation: reverseAnimation,
            animationDuration: animationDuration,
            decoration: decoration ?? ToastDecoration.origin,
            child: child,
          ),
        );
      },
    );

    Overlay.of(context).insert(_toastEntry!);
  }
}
