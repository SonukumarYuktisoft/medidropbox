// ignore_for_file: deprecated_member_use

import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';


extension ContainerExtension on Widget {
  Widget radiusContainer({
    double radius = 10,
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxBorder? border,
    double? width,
    double? height,
    Alignment? alignment,
  }) {
    return Container(
      alignment: alignment ?? Alignment.center,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        border: border,
      ),
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      child: this,
    );
  }

  Widget leftRadiusContainer({
    double radius = 10,
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxBorder? border,
    double? width,
    double? height,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.horizontal(left: Radius.circular(radius)),
        border: border,
      ),
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      child: this,
    );
  }

  Widget rightRadiusContainer({
    double radius = 10,
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxBorder? border,
    double? width,
    double? height,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.horizontal(right: Radius.circular(radius)),
        border: border,
      ),
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      child: this,
    );
  }

  Widget rightbottomCornnerContainer({
    double radius = 10,
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxBorder? border,
    double? width,
    double? height,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
        border: border,
      ),
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      child: this,
    );
  }

  Widget leftTopCornnerContainer({
    double radius = 10,
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxBorder? border,
    double? width,
    double? height,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
        border: border,
      ),
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      child: this,
    );
  }

  Widget radiusContainerWithShadow({
    double radius = 10,
    double? width,
    double? height,
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxBorder? border,
    Key? key,
  }) {
    return Container(
      key: key,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
        border: border,
      ),
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      child: this,
    );
  }

  Widget radiusContainerWithBorder({
    double radius = 10,
    double? width,
    double? height,
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? borderColor,
    double borderWidth = 1.0,

    AlignmentGeometry? alignment,
  }) {
    return Container(
      alignment: alignment,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: borderColor ?? Colors.grey,
          width: borderWidth,
        ),
      ),
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      child: this,
    );
  }

  Widget circularContainer({
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxBorder? border,
    double? size,
    AlignmentGeometry? alignment,
  }) {
    return Container(
      alignment: alignment,
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        shape: BoxShape.circle,
        border: border,
      ),
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      child: this,
    );
  }

  Widget circularContainerWithShadow({
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxBorder? border,
    double? size,
  }) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
        border: border,
      ),
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      child: this,
    );
  }

  Widget circularContainerWithBorder({
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    required Color borderColor,
    double borderWidth = 1.0,
    double? size,
  }) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      child: this,
    );
  }

  Widget gradientContainer({
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? width,
    double? height,
    double topLeft = 0,
    double? radius,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
    List<Color>? colors,
    List<double>? stops,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    DecorationImage? image,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: image,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius ?? topLeft),
          topRight: Radius.circular(radius ?? topRight),
          bottomLeft: Radius.circular(radius ?? bottomLeft),
          bottomRight: Radius.circular(radius ?? bottomRight),
        ),
        color: color ?? Colors.transparent,
        gradient: LinearGradient(
          stops: stops,
          begin: begin,
          end: end,
          colors: colors ?? [Colors.green, Colors.yellow],
        ),
      ),
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      child: this,
    );
  }

  Widget onlyRadiusContainer({
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxBorder? border,
    double? width,
    double? height,
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    AlignmentGeometry? alignment,
    double bottomRight = 0,
  }) {
    return Container(
      alignment: alignment,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft),
          bottomLeft: Radius.circular(bottomLeft),
          topRight: Radius.circular(topRight),
          bottomRight: Radius.circular(bottomRight),
        ),
        border: border,
      ),
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      child: this,
    );
  }

  Widget bottomRadiusContainer({
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxBorder? border,
    double? width,
    double? height,
    double? radius,
    AlignmentGeometry? alignment
  }) {
    return Container(
      height: height,
      width: width,
      alignment:alignment ,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(radius ?? 10),
        ),
        border: border,
      ),
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      child: this,
    );
  }

  Widget topRadiusContainer({
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxBorder? border,
    double? width,
    double? height,
    double? radius,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color ?? Colors.transparent,
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius ?? 10)),
        border: border,
      ),
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      child: this,
    );
  }

  Widget gradientGlassContainer({
    Color? color,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? width,
    double? height,
    double topLeft = 0,
    double? radius,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
    List<Color>? colors,
    List<double>? stops,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    DecorationImage? image,
    double blurStrength = 10.0,
    double opacity = 0.2,
  }) {
    return Container(
      width: width,
      height: height,
      margin: margin ?? EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius ?? topLeft),
          topRight: Radius.circular(radius ?? topRight),
          bottomLeft: Radius.circular(radius ?? bottomLeft),
          bottomRight: Radius.circular(radius ?? bottomRight),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
          child: Container(
            padding: padding ?? EdgeInsets.zero,
            decoration: BoxDecoration(
              image: image,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius ?? topLeft),
                topRight: Radius.circular(radius ?? topRight),
                bottomLeft: Radius.circular(radius ?? bottomLeft),
                bottomRight: Radius.circular(radius ?? bottomRight),
              ),
              // Remove 'color' property when using gradient
              gradient: LinearGradient(
                stops: stops,
                begin: begin,
                end: end,
                colors:
                    colors ??
                    (color != null
                        ? [
                            color.withOpacity(opacity),
                            color.withOpacity(opacity * 0.5),
                          ]
                        : [
                            Colors.yellow.withOpacity(opacity),
                            Colors.red.withOpacity(opacity * 0.5),
                          ]),
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: this,
          ),
        ),
      ),
    );
  }
}

// Add to your extensions file
List<Shadow> toIconShadow({
  Color shadowColor = Colors.black26,
  double blurRadius = 4.0,
  Offset offset = const Offset(0, 2),
}) {
  return [Shadow(color: shadowColor, blurRadius: blurRadius, offset: offset)];
}
