import 'package:intl/intl.dart';

extension DateExtension on DateTime? {
  String get ddMMyyyy {
    if (this == null) return "";
    return DateFormat('dd-MM-yyyy').format(this!);
  }

  String get readableDate {
    if (this == null) return "";
    return DateFormat('dd MMM yyyy').format(this!);
  }

  String get apiDate {
    if (this == null) return "";
    return DateFormat('yyyy-MM-dd').format(this!);
  }
}
