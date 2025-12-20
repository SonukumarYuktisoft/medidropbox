extension StringExtension on String? {
  bool get isNullOrEmpty =>
      this == null || this!.trim().isEmpty;

  String get capitalize {
    if (isNullOrEmpty) return "";
    return this![0].toUpperCase() + this!.substring(1);
  }

  String get titleCase {
    if (isNullOrEmpty) return "";
    return this!
        .split(" ")
        .map((e) => e.capitalize)
        .join(" ");
  }
  
}
