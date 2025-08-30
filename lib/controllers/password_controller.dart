import 'dart:convert';
import 'dart:math';

class PasswordController {
  List<String> buildSeed({
      String service = '',
      String passphrase = '',
      String username = '',
      int year = 0,
  }) {
    return [
      service.trim(),
      passphrase.trim(),
      username.trim(),
      year.toString()
    ];
  }

  void printSeed(List<String> seed) {
    print("Seed:");
    for (var part in seed) {
      print(" - $part");
    }
  }
}
