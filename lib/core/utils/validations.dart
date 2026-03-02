import 'package:jobify_project/generated/l10n.dart';

class Validations {
  Validations._();

  static String? validateEmail(String? val) {
    // Improved Email Regex (Standard HTML5)
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (val == null) {
      return AppLocalizations.current.emailIsRequired;
    } else if (val.trim().isEmpty) {
      return AppLocalizations.current.emailIsRequired;
    } else if (!emailRegex.hasMatch(val)) {
      return AppLocalizations.current.enterValidEmail;
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.current.passwordIsRequired;
    }

    if (value.length < 8) {
      return AppLocalizations.current.passwordMinLength;
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return AppLocalizations.current.passwordMustContainUppercase;
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return AppLocalizations.current.passwordMustContainLowercase;
    }

    if (!RegExp(r'\d').hasMatch(value)) {
      return AppLocalizations.current.passwordMustContainNumber;
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=\[\]\\\/`~]').hasMatch(value)) {
      return AppLocalizations.current.passwordMustContainSpecialChar;
    }

    if (value.contains(' ')) {
      return AppLocalizations.current.passwordMustNotContainSpaces;
    }

    return null;
  }

  static String? validateConfirmPassword(
    String? confirmPassword,
    String? originalPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return AppLocalizations.current.confirmPasswordIsRequired;
    }

    if (originalPassword == null || originalPassword.isEmpty) {
      return AppLocalizations.current.passwordIsRequired;
    }

    if (confirmPassword != originalPassword) {
      return AppLocalizations.current.passwordMismatch;
    }

    return null;
  }

  static String? validateUsername(String? val) {
    // Alphanumeric, dot, comma, hyphen.
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9,.-]+$');
    if (val == null) {
      return AppLocalizations.current.thisFieldIsRequired;
    } else if (val.isEmpty) {
      return AppLocalizations.current.thisFieldIsRequired;
    } else if (!usernameRegex.hasMatch(val)) {
      return AppLocalizations.current.enterValidUsername;
    } else {
      return null;
    }
  }

  static String? validateFullName(String? val) {
    if (val == null || val.isEmpty) {
      if (val!.length > 20) {
        return AppLocalizations
            .current
            .fullNameTooLongMustBeLessThan20Characters;
      }
      return AppLocalizations.current.thisFieldIsRequired;
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? val) {
    // Egyptian Phone Number: Optional +2, then 01, then digit (0,1,2,5), then 8 digits.
    final regex = RegExp(r'^(?:\+2)?01[0125][0-9]{8}$');

    if (val == null || val.trim().isEmpty) {
      return AppLocalizations.current.thisFieldIsRequired;
    } else if (int.tryParse(val.trim()) == null) {
      return AppLocalizations.current.enterNumbersOnly;
    } else if (!regex.hasMatch(val.trim())) {
      return AppLocalizations.current.enterValidEgyptianPhoneNumber;
    } else {
      return null;
    }
  }

  static String? validateAddress(String? val) {
    // Unicode letters, numbers, spaces, comma, dot, hyphen, slash, hash.
    final RegExp addressRegex = RegExp(r"^[\p{L}\d\s,.\-\/#]+$", unicode: true);

    if (val == null || val.trim().isEmpty) {
      return AppLocalizations.current.pleaseEnterAddress;
    }

    if (!addressRegex.hasMatch(val.trim())) {
      return AppLocalizations.current.pleaseEnterValidAddress;
    }

    return null;
  }
}
