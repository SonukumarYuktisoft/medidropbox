extension AmountExtension on num? {
  String get formatAmount {
    if (this == null) return "₹0.00";
    return "₹${this!.toStringAsFixed(2)}";
  }

  String get compactAmount {
    if (this == null) return "₹0";
    if (this! >= 10000000) {
      return "₹${(this! / 10000000).toStringAsFixed(1)}Cr";
    } else if (this! >= 100000) {
      return "₹${(this! / 100000).toStringAsFixed(1)}L";
    } else if (this! >= 1000) {
      return "₹${(this! / 1000).toStringAsFixed(1)}K";
    }
    return "₹${this!.toStringAsFixed(0)}";
  }
}
