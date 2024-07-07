import 'package:flutter/material.dart';
import 'default_widget.dart';

class OverlayWidget extends StatefulWidget {
  final bool barrierDismissible;
  final Color barrierColor;
  final Function()? onTap;
  final Duration duration; // Duration for animation
  final Widget? child;

  const OverlayWidget({
    super.key,
    this.child,
    required this.onTap,
    required this.barrierDismissible,
    this.barrierColor = Colors.black38,
    this.duration = const Duration(milliseconds: 300), // Default duration
  });

  @override
  State<OverlayWidget> createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      _animationController,
    );

    // Start the animation when the widget is initialized
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: GestureDetector(
        onTap: widget.barrierDismissible
            ? () {
                widget.onTap?.call();
                _animationController.reverse(); // Fade out animation on tap
              }
            : null,
        child: Container(
          color: widget.barrierColor,
          constraints: const BoxConstraints.expand(),
          child: GestureDetector(
            onTap: () {
              //To ensure the widget doesn’t close when its child is clicked.
            },
            child: Center(
              child: widget.child ?? const DefaultWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
