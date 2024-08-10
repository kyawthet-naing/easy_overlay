import '/easy_overlay.dart';
import 'package:flutter/material.dart';

class ToastOverlay extends StatefulWidget {
  final Widget? child;
  final String? message;
  final Duration duration;
  final Duration animationDuration;
  final bool reverseAnimation;
  final VoidCallback dimissOverlay;
  final ToastDecoration decoration;
  final AnimationType animationType;

  const ToastOverlay({
    super.key,
    required this.decoration,
    required this.child,
    required this.dimissOverlay,
    required this.message,
    required this.duration,
    required this.reverseAnimation,
    required this.animationDuration,
    this.animationType = AnimationType.slideUp,
  });

  @override
  ToastOverlayState createState() => ToastOverlayState();
}

class ToastOverlayState extends State<ToastOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _setupAnimations();

    _animationController.forward().whenComplete(() {
      Future.delayed(widget.duration, () {
        if (!mounted) return;
        if (widget.reverseAnimation) {
          _animationController.reverse().whenComplete(() {
            widget.dimissOverlay();
          });
        } else {
          widget.dimissOverlay();
        }
      });
    });
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
      child: _buildAnimation(),
    );
  }

  Widget _buildAnimation() {
    switch (widget.animationType) {
      case AnimationType.fade:
        return _buildToastContent();

      case AnimationType.scale:
        return ScaleTransition(
          scale: _scaleAnimation,
          child: _buildToastContent(),
        );

      case AnimationType.rotate:
        return RotationTransition(
          turns: _rotationAnimation,
          child: _buildToastContent(),
        );

      case AnimationType.scaleFade:
        return ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: _buildToastContent(),
          ),
        );

      case AnimationType.slideUp:
      case AnimationType.slideDown:
      case AnimationType.slideRight:
      case AnimationType.slideLeft:
        return SlideTransition(
          position: _offsetAnimation,
          child: _buildToastContent(),
        );

      case AnimationType.slideFade:
        return SlideTransition(
          position: _offsetAnimation,
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: _buildToastContent(),
          ),
        );

      default:
        return SlideTransition(
          position: _offsetAnimation,
          child: _buildToastContent(),
        );
    }
  }

  Widget _buildToastContent() {
    return Material(
      color: Colors.transparent,
      child: widget.child ??
          FittedBox(
            fit: BoxFit.scaleDown, // Ensures the container wraps its content
            child: Container(
              margin: widget.decoration.margin,
              padding: widget.decoration.padding,
              decoration: BoxDecoration(
                color: widget.decoration.backgroundColor,
                borderRadius: widget.decoration.borderRadius,
              ),
              child: Text(
                widget.message!,
                style: widget.decoration.textStyle ??
                    const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
    );
  }

  void _setupAnimations() {
    switch (widget.animationType) {
      case AnimationType.slideUp:
        _offsetAnimation = Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ));
        break;

      case AnimationType.slideDown:
        _offsetAnimation = Tween<Offset>(
          begin: const Offset(0.0, -1.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ));
        break;

      case AnimationType.slideRight:
        _offsetAnimation = Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ));
        break;

      case AnimationType.slideLeft:
        _offsetAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ));
        break;

      case AnimationType.scale:
        _scaleAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ));
        break;

      case AnimationType.rotate:
        _rotationAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ));
        break;

      case AnimationType.scaleFade:
        _scaleAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ));
        break;

      case AnimationType.slideFade:
        _offsetAnimation = Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ));
        break;

      default:
        _offsetAnimation = Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ));
    }
  }
}
