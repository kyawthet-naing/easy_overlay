import 'package:flutter/material.dart';

class ToastDecoration {
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  ToastDecoration({
    this.textStyle,
    this.backgroundColor,
    this.margin,
    this.borderRadius,
    this.padding,
  });

  static ToastDecoration get origin {
    return ToastDecoration(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      backgroundColor: Colors.black.withOpacity(.7),
      textStyle: const TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
    );
  }

  // CopyWith method to create a new instance with modified values
  ToastDecoration copyWith({
    TextStyle? textStyle,
    Color? backgroundColor,
    EdgeInsetsGeometry? margin,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return ToastDecoration(
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      margin: margin ?? this.margin,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
    );
  }
}
