import 'package:intl/intl.dart';

/// A comprehensive price formatting utility class
class AppPriceFormatter {
  // Private constructor to prevent instantiation
  AppPriceFormatter._();
  // Default configuration
  static const String _defaultCurrency = '₹';
  static const String _defaultLocale = 'en_IN';
  static const int _defaultDecimalPlaces = 2;

  /// Main formatting method with full customization
  static String format(
    dynamic value, {
    String currencySymbol = _defaultCurrency,
    String locale = _defaultLocale,
    int decimalPlaces = _defaultDecimalPlaces,
    bool showCurrency = true,
    bool showTrailingZeros = true,
    bool useCompactFormat = false,
  }) {
    try {
      // Handle null or empty values
      if (value == null) return '';

      String stringValue = value.toString().trim();
      if (stringValue.isEmpty) return '';

      // Clean the input - remove everything except digits, decimal point, and minus sign
      String cleanValue = stringValue.replaceAll(RegExp(r'[^\d.-]'), '');

      if (cleanValue.isEmpty || cleanValue == '-') return '';

      // Handle multiple decimal points
      List<String> parts = cleanValue.split('.');
      if (parts.length > 2) {
        cleanValue = '${parts[0]}.${parts.sublist(1).join('')}';
      }

      double price = double.parse(cleanValue);

      // Use compact format if requested
      if (useCompactFormat) {
        return _formatCompact(price, currencySymbol, showCurrency);
      }

      // Create number formatter
      final formatter = NumberFormat.currency(
        locale: locale,
        symbol: showCurrency ? currencySymbol : '',
        decimalDigits: showTrailingZeros ? decimalPlaces : 0,
      );

      String formatted = formatter.format(price);

      // Remove trailing zeros if not required
      if (!showTrailingZeros && formatted.contains('.')) {
        formatted = formatted.replaceAll(RegExp(r'\.?0+$'), '');
      }

      return formatted;
    } catch (e) {
      return value?.toString() ?? '';
    }
  }

  /// Format with Indian number system (default)
  /// Format with Indian currency symbol but Western (international) number formatting
  static String indian(
    dynamic value, {
    bool showCurrency = true,
    int decimalPlaces = _defaultDecimalPlaces,
    bool showTrailingZeros = false,
  }) {
    return format(
      value,
      currencySymbol: _defaultCurrency,
      locale: 'en_US', // Western number grouping
      showCurrency: showCurrency,
      decimalPlaces: decimalPlaces,
      showTrailingZeros: showTrailingZeros,
    );
  }

  static String removeNumeric(String value) {
    final numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    return numericValue;
  }

  /// Format with US number system
  static String us(
    dynamic value, {
    String currencySymbol = '\$',
    bool showCurrency = true,
    int decimalPlaces = _defaultDecimalPlaces,
    bool showTrailingZeros = true,
  }) {
    return format(
      value,
      currencySymbol: currencySymbol,
      locale: 'en_US',
      showCurrency: showCurrency,
      decimalPlaces: decimalPlaces,
      showTrailingZeros: showTrailingZeros,
    );
  }

  /// Format without currency symbol
  static String withoutCurrency(
    dynamic value, {
    String locale = _defaultLocale,
    int decimalPlaces = _defaultDecimalPlaces,
    bool showTrailingZeros = true,
  }) {
    return format(
      value,
      showCurrency: false,
      locale: locale,
      decimalPlaces: decimalPlaces,
      showTrailingZeros: showTrailingZeros,
    );
  }

  /// Compact format (1.2Cr, 5.6L, 7.8K)
  static String compact(
    dynamic value, {
    String currencySymbol = _defaultCurrency,
    bool showCurrency = true,
    int decimalPlaces = 1,
  }) {
    try {
      if (value == null) return '';

      String stringValue = value.toString().trim();
      if (stringValue.isEmpty) return '';

      String cleanValue = stringValue.replaceAll(RegExp(r'[^\d.-]'), '');
      if (cleanValue.isEmpty) return '';

      double price = double.parse(cleanValue);
      return _formatCompact(price, currencySymbol, showCurrency, decimalPlaces);
    } catch (e) {
      return value?.toString() ?? '';
    }
  }

  /// Format for display in lists (shorter format)
  static String forList(
    dynamic value, {
    String currencySymbol = _defaultCurrency,
    bool showCurrency = true,
  }) {
    return compact(
      value,
      currencySymbol: currencySymbol,
      showCurrency: showCurrency,
    );
  }

  /// Format for detailed view (full format)
  static String forDetail(
    dynamic value, {
    String currencySymbol = _defaultCurrency,
    bool showCurrency = true,
    int decimalPlaces = _defaultDecimalPlaces,
  }) {
    return indian(
      value,
      showCurrency: showCurrency,
      decimalPlaces: decimalPlaces,
      showTrailingZeros: true,
    );
  }

  /// Parse formatted price back to double
  static double? parsePrice(String? formattedPrice) {
    try {
      if (formattedPrice == null || formattedPrice.isEmpty) return null;

      // Remove all non-numeric characters except decimal point and minus
      String cleanValue = formattedPrice.replaceAll(RegExp(r'[^\d.-]'), '');

      if (cleanValue.isEmpty) return null;

      return double.parse(cleanValue);
    } catch (e) {
      return null;
    }
  }

  /// Validate if string is a valid price
  static bool isValidPrice(String? value) {
    if (value == null || value.isEmpty) return false;

    try {
      String cleanValue = value.replaceAll(RegExp(r'[^\d.-]'), '');
      if (cleanValue.isEmpty) return false;

      double.parse(cleanValue);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get price without currency symbol
  static String getNumericPrice(String? formattedPrice) {
    if (formattedPrice == null || formattedPrice.isEmpty) return '';

    return formattedPrice.replaceAll(RegExp(r'[^\d.,-]'), '');
  }

  /// Format percentage
  static String formatPercentage(
    dynamic value, {
    int decimalPlaces = 1,
    bool showSign = true,
  }) {
    try {
      if (value == null) return '';

      double percentage = double.parse(value.toString());
      String formatted = percentage.toStringAsFixed(decimalPlaces);

      if (showSign && percentage > 0) {
        formatted = '+$formatted';
      }

      return '$formatted%';
    } catch (e) {
      return value?.toString() ?? '';
    }
  }

  /// Format discount (always shows as positive with % symbol)
  static String formatDiscount(
    dynamic value, {
    int decimalPlaces = 0,
    String prefix = '',
  }) {
    try {
      if (value == null) return '';

      double discount = double.parse(value.toString()).abs();
      String formatted = discount.toStringAsFixed(decimalPlaces);

      return '$prefix$formatted% OFF';
    } catch (e) {
      return value?.toString() ?? '';
    }
  }

  // Private helper method for compact formatting
  static String _formatCompact(
    double price,
    String currencySymbol,
    bool showCurrency, [
    int decimalPlaces = 1,
  ]) {
    String prefix = showCurrency ? currencySymbol : '';

    if (price.abs() >= 10000000) {
      // 1 crore
      double crores = price / 10000000;
      return '$prefix${crores.toStringAsFixed(decimalPlaces)}Cr';
    } else if (price.abs() >= 100000) {
      // 1 lakh
      double lakhs = price / 100000;
      return '$prefix${lakhs.toStringAsFixed(decimalPlaces)}L';
    } else if (price.abs() >= 1000) {
      // 1 thousand
      double thousands = price / 1000;
      return '$prefix${thousands.toStringAsFixed(decimalPlaces)}K';
    } else {
      return '$prefix${price.toStringAsFixed(decimalPlaces == 1 ? 0 : decimalPlaces)}';
    }
  }

  /// Get currency symbol for different countries
  static String getCurrencySymbol(String countryCode) {
    switch (countryCode.toUpperCase()) {
      case 'IN':
      case 'IND':
        return '₹';
      case 'US':
      case 'USA':
        return '\$';
      case 'GB':
      case 'UK':
        return '£';
      case 'EU':
      case 'EUR':
        return '€';
      case 'JP':
      case 'JPN':
        return '¥';
      case 'CN':
      case 'CHN':
        return '¥';
      default:
        return '₹';
    }
  }

  /// Format price with custom configuration
  static String formatWithConfig(dynamic value, AppPriceFormatterConfig config) {
    return format(
      value,
      currencySymbol: config.currencySymbol,
      locale: config.locale,
      decimalPlaces: config.decimalPlaces,
      showCurrency: config.showCurrency,
      showTrailingZeros: config.showTrailingZeros,
      useCompactFormat: config.useCompactFormat,
    );
  }

  static debbugPriceFormateExample() {
    // Test values
    List<dynamic> testValues = [
      1234567.89,
      '1000000',
      50000.5,
      '1234',
      100,
      '0',
      -500,
      '₹1,23,456.78',
      'abc123',
      null,
      '',
    ];

    print('1. BASIC FORMATTING:');
    for (var value in testValues) {
      print('$value -> ${AppPriceFormatter.indian(value)}');
    }

    print('\n2. COMPACT FORMATTING:');
    List<dynamic> compactValues = [12345678, 1234567, 123456, 12345, 1234, 123];
    for (var value in compactValues) {
      print('$value -> ${AppPriceFormatter.compact(value)}');
    }

    print('\n3. DIFFERENT FORMATS:');
    double testAmount = 1234567.89;

    print('Indian: ${AppPriceFormatter.indian(testAmount)}');
    print('US: ${AppPriceFormatter.us(testAmount)}');
    print('Without Currency: ${AppPriceFormatter.withoutCurrency(testAmount)}');
    print('Compact: ${AppPriceFormatter.compact(testAmount)}');
    print('For List: ${AppPriceFormatter.forList(testAmount)}');
    print('For Detail: ${AppPriceFormatter.forDetail(testAmount)}');

    print('\n4. CUSTOM FORMATTING:');
    print(
      'Custom 1: ${AppPriceFormatter.format(testAmount, currencySymbol: '\$', locale: 'en_US', decimalPlaces: 0)}',
    );

    print(
      'Custom 2: ${AppPriceFormatter.format(testAmount, showCurrency: false, showTrailingZeros: false)}',
    );

    print('\n5. USING CONFIGURATIONS:');
    print(
      'Indian Config: ${AppPriceFormatter.formatWithConfig(testAmount, AppPriceFormatterConfig.indian)}',
    );
    print(
      'US Config: ${AppPriceFormatter.formatWithConfig(testAmount, AppPriceFormatterConfig.us)}',
    );
    print(
      'Compact Config: ${AppPriceFormatter.formatWithConfig(testAmount, AppPriceFormatterConfig.compact)}',
    );

    print('\n6. EXTENSION METHODS:');
    print('Number extension: ${testAmount.toPrice()}');
    print('Compact extension: ${testAmount.toPriceCompact()}');
    print('US extension: ${testAmount.toPriceUS()}');
    print('String extension: ${"123456.78".toPrice()}');

    print('\n7. UTILITY METHODS:');
    String formattedPrice = '₹1,23,456.78';
    print('Parse price: ${AppPriceFormatter.parsePrice(formattedPrice)}');
    print('Is valid: ${AppPriceFormatter.isValidPrice("123.45")}');
    print('Get numeric: ${AppPriceFormatter.getNumericPrice(formattedPrice)}');

    print('\n8. PERCENTAGE & DISCOUNT:');
    print('Percentage: ${AppPriceFormatter.formatPercentage(15.5)}');
    print('Discount: ${AppPriceFormatter.formatDiscount(25)}');

    print('\n9. CURRENCY SYMBOLS:');
    print('India: ${AppPriceFormatter.getCurrencySymbol('IN')}');
    print('USA: ${AppPriceFormatter.getCurrencySymbol('US')}');
    print('UK: ${AppPriceFormatter.getCurrencySymbol('GB')}');

    print('\n10. VALIDATION:');
    List<String> validationTests = ['123.45', '₹1,000', 'abc', '', '0'];
    for (String test in validationTests) {
      print('$test is valid: ${test.isValidPrice()}');
    }
  }
}

/// Configuration class for price formatting
class AppPriceFormatterConfig {
  final String currencySymbol;
  final String locale;
  final int decimalPlaces;
  final bool showCurrency;
  final bool showTrailingZeros;
  final bool useCompactFormat;

  const AppPriceFormatterConfig({
    this.currencySymbol = '₹',
    this.locale = 'en_IN',
    this.decimalPlaces = 2,
    this.showCurrency = true,
    this.showTrailingZeros = true,
    this.useCompactFormat = false,
  });

  // Predefined configurations
  static const AppPriceFormatterConfig indian = AppPriceFormatterConfig();

  static const AppPriceFormatterConfig us = AppPriceFormatterConfig(
    currencySymbol: '\$',
    locale: 'en_US',
  );

  static const AppPriceFormatterConfig compact = AppPriceFormatterConfig(
    useCompactFormat: true,
    decimalPlaces: 1,
  );

  static const AppPriceFormatterConfig withoutCurrency = AppPriceFormatterConfig(
    showCurrency: false,
  );
}

// Extension method for easy usage
extension AppPriceFormatterExtension on num {
  String toPrice([AppPriceFormatterConfig? config]) {
    return config != null
        ? AppPriceFormatter.formatWithConfig(this, config)
        : AppPriceFormatter.indian(this);
  }

  String toPriceCompact() => AppPriceFormatter.compact(this);

  String toPriceUS() => AppPriceFormatter.us(this);

  String toPriceWithoutCurrency() => AppPriceFormatter.withoutCurrency(this);
}

extension StringAppPriceFormatterExtension on String {
  String toPrice([AppPriceFormatterConfig? config]) {
    return config != null
        ? AppPriceFormatter.formatWithConfig(this, config)
        : AppPriceFormatter.indian(this);
  }

  String toPriceCompact() => AppPriceFormatter.compact(this);

  double? parseAsPrice() => AppPriceFormatter.parsePrice(this);

  bool isValidPrice() => AppPriceFormatter.isValidPrice(this);
}
