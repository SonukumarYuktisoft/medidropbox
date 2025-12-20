import 'package:flutter/material.dart';

extension TextStyleX on TextStyle? {
  TextStyle? withColor(Color color) =>
      this?.copyWith(color: color);
}
