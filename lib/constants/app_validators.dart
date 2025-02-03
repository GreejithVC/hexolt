import 'package:flutter/cupertino.dart';

class AppValidators {
  static FormFieldValidator<String> empty = (value) {
    if (value == null || value.isEmpty) {
      return 'Please fill';
    }
    return null;
  };

  static FormFieldValidator<String> email = (value) {
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Please fill';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  };

  static FormFieldValidator<String> password = (value) {
    if (value == null || value.isEmpty) {
      return 'Please fill';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (value.contains(' ')) {
      return 'Password must not contain whitespace';
    }
    return null;
  };
}
