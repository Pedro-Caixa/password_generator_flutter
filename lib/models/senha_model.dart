class Password {
  int _charMin = 8;
  int _charMax = 20;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasDigits = false;
  bool _hasSpecialCharacters = false;

  final List<String> _algorithms = ['SHA-256', 'SHA-512', 'PBKDF2'];
}
