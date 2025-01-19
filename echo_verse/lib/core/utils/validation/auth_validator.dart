class AuthValidator {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Email cannot be empty";
    }
    final regex = RegExp(r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return "Password should be at least 6 characters";
    }
    return null;
  }
  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'Name cannot be empty';
    }
    
    return null;
  }
}
