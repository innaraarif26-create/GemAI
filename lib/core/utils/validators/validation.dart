
class AppValidator {

  static String? validateEmptyText(String? fieldName, String? value)
  {
    if(value == null || value.isEmpty)
      {
        return "$fieldName is required.";
      }
    return null;
  }

  /*-------------------- Username Validation ----------------- */

  static String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required.';
    }

    const pattern = r"^[a-zA-Z0-9_-]{3,20}$";
    final regex = RegExp(pattern);
    bool isValid = regex.hasMatch(username);
    if (isValid) {
      isValid = !username.startsWith('_') && !username.startsWith('-') && !username.endsWith('_') && !username.endsWith('-');
    }
    if (!isValid) {
      return 'Username is not valid.';
    }
    return null;
  }

  /* -------------------- EMAIL -------------------- */
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    // Regular Expression
    final emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

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
      return 'Password must contain at least one special character';
    }
    return null;
  }

  /* -------------------- CONFIRM PASSWORD -------------------- */
  static String? validateConfirmPassword(String? password,
      String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }

    if ((password ?? "").trim() != confirmPassword.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  /* -------------------- PHONE NUMBER -------------------- */
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Number is required';
    }
    final returnValue = validatePhoneNumberFormat(value);

    return returnValue;
   }

  static String? validatePhoneNumberFormat(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    final phoneRegExp = RegExp(r'^\d{11}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (11 digits required)';
    }
    return null;
  }

}