import 'package:flutter/material.dart';
import 'widgets/overlay_widget.dart';

class EasyOverlay {
  static OverlayEntry? _overlayEntry;
  static BuildContext? _overlayContext;

  // Sets the context for overlay operations
  static void setOverlayContext(BuildContext context) {
    _overlayContext = context;
  }

  // Provides a function to initialize the Overlay
  static Widget Function(BuildContext, Widget?)? init() {
    return (context, child) {
      return Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) {
              // Set the overlay context for usage in OverlayView
              EasyOverlay.setOverlayContext(context);
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
          onTap: barrierDismissible ? EasyOverlay.dismiss : null,
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
}
