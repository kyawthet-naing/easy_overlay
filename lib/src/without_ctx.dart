import '/src/toast/toast_decoration.dart';
import 'package:flutter/material.dart';
import 'toast/animation_type.dart';
import 'widgets/overlay_widget.dart';
import 'toast/toast_overlay.dart';

class EasyOverlay {
  static OverlayEntry? _overlayEntry;
  static OverlayEntry? _toastEntry;
  static BuildContext? _overlayContext;

  // Sets the context for overlay operations
  static void _setOverlayContext(BuildContext context) {
    _overlayContext = context;
  }

  // Initializes the Overlay with context
  static Widget Function(BuildContext, Widget?)? init() {
    return (context, child) {
      _setOverlayContext(context);
      return Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) {
              // Set the overlay context for usage in OverlayView
              EasyOverlay._setOverlayContext(context);
              return child!;
            },
          ),
        ],
      );
    };
  }

  // Shows the overlay with the specified options
  static void show({
    Color barrierColor = Colors.black54,
    Widget? child,
    bool barrierDismissible = true,
  }) {
    if (_overlayEntry != null) return; // Exit if an overlay is already present

    if (_overlayContext == null) {
      debugPrint("Overlay context is not available");
      return;
    }

    final overlay = Overlay.of(_overlayContext!);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return OverlayWidget(
          onTap: barrierDismissible ? dismiss : null,
          barrierDismissible: barrierDismissible,
          barrierColor: barrierColor,
          child: child,
        );
      },
    );
    overlay.insert(_overlayEntry!);
  }

  // Hides the currently displayed overlay
  static void dismiss() {
    if (_overlayEntry == null) return;
    _overlayEntry!.remove();
    _overlayEntry = null;
  }

  // Hides the currently displayed toast
  static void _dismissToast() {
    _toastEntry?.remove();
    _toastEntry = null;
  }

  // Shows a toast message with a chosen animation
  static void showToast({
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

    if (_overlayContext == null) {
      debugPrint("Overlay context is not available");
      return;
    }

    final overlay = Overlay.of(_overlayContext!);

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

    overlay.insert(_toastEntry!);
  }
}
