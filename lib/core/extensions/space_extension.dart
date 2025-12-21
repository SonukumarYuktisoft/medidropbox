import 'package:flutter/material.dart';

extension SpaceExtension on num {
  /// Returns a vertical space of given height.
  Widget get heightBox => SizedBox(height: toDouble());

  /// Returns a horizontal space of given width.
  Widget get widthBox => SizedBox(width: toDouble());
}
