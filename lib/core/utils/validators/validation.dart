
class AppValidator {
  AppValidator._();

  /* -------------------- EMAIL -------------------- */
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email s required.';
    }

    // Regular Expression
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid Email Address';
    }
    return null;
  }

  /* -------------------- PASSWORD -------------------- */
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    // check for minimum password length
    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    // check for uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return ' Password must contain at least one upper letter.';
    }
    // check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }
    // check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one specail character';
    }
    return null;
  }

  /* -------------------- CONFIRM PASSWORD -------------------- */
  static String? validateConfirmPassword(String? password,
      String? confirmPassword,) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  /* -------------------- PHONE NUMBER -------------------- */
    static String? validatePhoneNumber(String? value)
    {
      if(value==null || value.isEmpty)
        {
          return 'Phone Number is required';

        }
      final phoneRegExp = RegExp(r'^\d{11}$');

      if(!phoneRegExp.hasMatch(value))
        {
          return 'Invalid phone number format (11 digits required';
        }
      return null;
    }

  /* -------------------- CNIC -------------------- */
  static String? validateCNIC(String? value)
  {
    if (value == null || value.isEmpty)
    {
      return 'CNIC is required';
    }

    // Format: 12345-1234567-1
    final cnicRegExp =
    RegExp(r'^\d{5}-\d{7}-\d{1}$');

    if (!cnicRegExp.hasMatch(value))
    {
      return 'Invalid CNIC format (XXXXX-XXXXXXX-X)';
    }

    return null;
  }
}