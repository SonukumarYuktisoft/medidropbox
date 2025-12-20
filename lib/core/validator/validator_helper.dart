class ValidatorHelper {
  /// Checks if the field is empty
  static String? isEmpty(String? value, {String fieldName = "This field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName cannot be empty";
    }
    return null;
  }

  /// Checks if email is valid
  static String? isValidEmail(String? value) {
    if (value == null || value.trim().isEmpty ||value.isEmpty) {
      return "Email is required";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return "Enter a valid email";
    }
    return null;
  }

  /// Checks if password is valid
  static String? isValidPassword(String? value, {int minLength = 6}) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }
    if (value.length < minLength) {
      return "Password must be at least $minLength characters long";
    }
    return null;
  }

 static String? isValidPhoneNumber(
  String? value, {
  int minLength = 10,
}) {
  if (value == null || value.trim().isEmpty) {
    return "Phone number is required";
  }

  final phone = value.trim();

  if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
    return "Phone number must contain only digits";
  }

  if (phone.length < minLength) {
    return "Phone number must be $minLength digits";
  }

  return null;
}

}
