// lib/products/validators/validators.dart
import 'package:flutter_mindmate_project/products/enums/error_strings.dart';

class Validators {
   Validators._();
  static final validatorsInstance = Validators._();

  final int passwordLength = 6;
  // Email validation pattern
   final RegExp emailRegex = RegExp(r'[a-zA-Z0-9@._+%-]');
  
  // Email validator method
   String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorStringsEnum.emailEmptyError.value;
    }
    if (!emailRegex.hasMatch(value)) {
      return ErrorStringsEnum.invalidEmailError.value;
    }
    return null;
  }
  
  // Password validator
   String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorStringsEnum.passwordEmptyError.value;
    }
    if (value.length < passwordLength) {
      return ErrorStringsEnum.passwordLengthError.value;
    }
    return null;
  }

  // Full Name validator
  String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return ErrorStringsEnum.fullNameEmptyError.value;
    }
    return null;
  }
}