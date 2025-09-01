class PasswordOptions {
  String service;
  String passphrase;
  int length;
  String? username;
  String? year;
  bool useUppercase;
  bool useNumbers;
  bool useSymbols;
  String? method;

  PasswordOptions({
    required this.service,
    required this.passphrase,
    required this.length,
    this.username,
    this.year,
    this.useUppercase = true,
    this.useNumbers = true,
    this.useSymbols = true,
    this.method = 'md5',
  }) : assert(length > 8 && length <= 32, 'Deve ter entre 8 e 32 caracteres');
}
