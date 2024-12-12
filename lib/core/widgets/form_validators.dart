class FormValidators {
  /// name validator
  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'User name is required';
    }
    if (value.length < 3) {
      return 'User name must be at least 3 characters';
    }
    return null;
  }

  /// email validator
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  /// password validator
  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// password match validator
  static String? passwordMatchValidator(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Password is empty';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
