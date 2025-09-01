import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';
import '../models/password_model.dart';

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
      year.toString(),
    ];
  }

  void printSeed(List<String> seed) {
    print("Seed:");
    for (var part in seed) {
      print(" - $part");
    }
  }

  List<String> buildSeedFromOptions(PasswordOptions options) {
    return [
      options.service.trim(),
      options.passphrase.trim(),
      options.username?.trim() ?? '',
      options.year?.trim() ?? '',
    ];
  }

  String generatePassword(PasswordOptions options) {
    final seed = buildSeedFromOptions(options).join('|');

    late Digest digest;
    switch (options.method) {
      case 'sha256':
        digest = sha256.convert(utf8.encode(seed));
        break;
      case 'md5':
        digest = md5.convert(utf8.encode(seed));
        break;
      case 'sha1':
        digest = sha1.convert(utf8.encode(seed));
        break;
      default:
        digest = sha256.convert(utf8.encode(seed));
        break;
    }

    var password = digest.toString();

    password = password.toLowerCase();

    password = formatPassword(
      password,
      options.length,
      options.useUppercase,
      options.useNumbers,
      options.useSymbols,
    );

    return password;
  }

  String formatPassword(
    String password,
    int length,
    bool useUppercase,
    bool useNumbers,
    bool useSymbols,
  ) {
    if (password.length < length) {
      final buf = StringBuffer();
      while (buf.length < length) {
        buf.write(password);
      }
      password = buf.toString().substring(0, length);
    } else if (password.length > length) {
      password = password.substring(0, length);
    }

    final rand = Random.secure();

    if (useNumbers) {
      password = password.replaceAllMapped(
        RegExp(r'[a-f]', caseSensitive: false),
        (_) => rand.nextInt(10).toString(),
      );
    }

    if (useSymbols) {
      const symbols = '!@#\$%^&*()_-+=<>?';
      password = password.replaceAllMapped(
        RegExp(r'[0-9]'),
        (_) => symbols[rand.nextInt(symbols.length)],
      );
    }

    if (useUppercase) {
      password = password
          .split('')
          .map((c) => rand.nextBool() ? c.toUpperCase() : c)
          .join();
    }

    return password;
  }

  void copyToClipboard(String password) {
    Clipboard.setData(ClipboardData(text: password));
  }
}
