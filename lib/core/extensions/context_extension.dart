import 'package:flutter/material.dart';

extension ContextX on BuildContext {
  double get w => MediaQuery.of(this).size.width;
  double get h => MediaQuery.of(this).size.height;

  ThemeData get theme => Theme.of(this);
  TextTheme get text => theme.textTheme;
}
