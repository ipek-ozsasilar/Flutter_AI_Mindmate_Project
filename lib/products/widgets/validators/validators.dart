// lib/products/validators/validators.dart
class Validators {
   Validators._();
  static final validatorsInstance = Validators._();
  
  // Email validation pattern
   final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
  );
  
  // Email validator method
   String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email boş olamaz';
    }
    if (!emailRegex.hasMatch(value)) {
      return 'Geçerli bir email adresi giriniz';
    }
    return null;
  }
  
  // Password validator
   String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre boş olamaz';
    }
    if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalıdır';
    }
    return null;
  }
}