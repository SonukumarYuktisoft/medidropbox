class ValidatorHelper {
  /// Checks if the field is empty
  static String? isEmpty(String? value, {String fieldName = "This field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName cannot be empty";
    }
    return null;
  }
 
   static String? required(
    String? value, {
    required String fieldName,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  static String? isValidUsername(
    String? value, {
    String fieldName = "Username",
    int minLength = 3,
    int maxLength = 20,
  }) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName cannot be empty";
    }

    final username = value.trim();

    if (username.length < minLength) {
      return "$fieldName must be at least $minLength characters";
    }

    if (username.length > maxLength) {
      return "$fieldName must be at most $maxLength characters";
    }

    if (username.contains(' ')) {
      return "$fieldName cannot contain spaces";
    }

    final regex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!regex.hasMatch(username)) {
      return "$fieldName can contain only letters, numbers and underscore";
    }

    return null;
  }

  /// Checks if email is valid
  static String? isValidEmail(String? value) {
    if (value == null || value.trim().isEmpty || value.isEmpty) {
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

  static String? isValidPhoneNumber(String? value, {int minLength = 10}) {
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

  static String? isValidAadhar(String? value, {int minLength = 12}) {
    if (value == null || value.trim().isEmpty) {
      return "Aadhar number is required";
    }

    final phone = value.trim();

    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      return "Aadhar number must contain only digits";
    }

    if (phone.length < minLength) {
      return "Aadhar number must be $minLength digits";
    }

    return null;
  }

  static String? isValidAddress(
    String? value, {
    String fieldName = "Address",
    int minLength = 5,
  }) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter $fieldName";
    }

    if (value.trim().length < minLength) {
      return "$fieldName must be at least $minLength characters";
    }

    return null;
  }

  static String? isValidPincode(String? value, {String fieldName = "Pincode"}) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter $fieldName";
    }

    final pincode = value.trim();

    // Only digits & exactly 6 digits
    final regex = RegExp(r'^[1-9][0-9]{5}$');

    if (!regex.hasMatch(pincode)) {
      return "Please enter a valid 6-digit $fieldName";
    }

    return null;
  }
}
