import 'package:flutter/material.dart';

extension WidgetPaddingExtension on Widget {
  // All sides padding
  Padding paddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  // Symmetric padding
  Padding paddingSymmetric({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  // Individual sides
  Padding paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: left, top: top, right: right, bottom: bottom),
      child: this,
    );
  }

  // Horizontal padding
  Padding paddingHorizontal(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value),
      child: this,
    );
  }

  // Vertical padding
  Padding paddingVertical(double value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: value),
      child: this,
    );
  }

  // Left padding
  Padding paddingLeft(double value) {
    return Padding(
      padding: EdgeInsets.only(left: value),
      child: this,
    );
  }

  // Right padding
  Padding paddingRight(double value) {
    return Padding(
      padding: EdgeInsets.only(right: value),
      child: this,
    );
  }

  // Top padding
  Padding paddingTop(double value) {
    return Padding(
      padding: EdgeInsets.only(top: value),
      child: this,
    );
  }

  // Bottom padding
  Padding paddingBottom(double value) {
    return Padding(
      padding: EdgeInsets.only(bottom: value),
      child: this,
    );
  }

  // Custom EdgeInsets
  Padding paddingCustom(EdgeInsetsGeometry padding) {
    return Padding(
      padding: padding,
      child: this,
    );
  }

  // Zero padding (useful for removing default padding)
  Padding paddingZero() {
    return Padding(
      padding: EdgeInsets.zero,
      child: this,
    );
  }

  // LTRB (Left, Top, Right, Bottom)
  Padding paddingLTRB(double left, double top, double right, double bottom) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: this,
    );
  }
}
