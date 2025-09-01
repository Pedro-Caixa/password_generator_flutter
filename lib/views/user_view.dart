import 'package:flutter/material.dart';
import '../controllers/password_controller.dart';
import '../models/password_model.dart';

class PasswordView extends StatefulWidget {
  const PasswordView({super.key});

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  final PasswordController _controller = PasswordController();

  final _serviceController = TextEditingController();
  final _passphraseController = TextEditingController();
  final _usernameController = TextEditingController();
  final _yearController = TextEditingController();

  bool _useUppercase = true;
  bool _useNumbers = true;
  bool _useSymbols = true;
  String _method = "sha256";
  double _length = 12;

  String _generatedPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Password Generator")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _serviceController,
              decoration: const InputDecoration(labelText: "Service"),
            ),
            TextField(
              controller: _passphraseController,
              decoration: const InputDecoration(labelText: "Passphrase"),
              obscureText: true,
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: _yearController,
              decoration: const InputDecoration(labelText: "Year"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Text("Password length: ${_length.toInt()}"),
            Slider(
              value: _length,
              min: 8,
              max: 32,
              divisions: 24,
              label: _length.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  _length = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text("Use Uppercase"),
              value: _useUppercase,
              onChanged: (val) => setState(() => _useUppercase = val),
            ),
            SwitchListTile(
              title: const Text("Use Numbers"),
              value: _useNumbers,
              onChanged: (val) => setState(() => _useNumbers = val),
            ),
            SwitchListTile(
              title: const Text("Use Symbols"),
              value: _useSymbols,
              onChanged: (val) => setState(() => _useSymbols = val),
            ),
            DropdownButtonFormField<String>(
              value: _method,
              items: const [
                DropdownMenuItem(value: "sha256", child: Text("SHA-256")),
                DropdownMenuItem(value: "md5", child: Text("MD5")),
                DropdownMenuItem(value: "sha1", child: Text("SHA-1")),
              ],
              onChanged: (value) {
                setState(() => _method = value ?? "sha256");
              },
              decoration: const InputDecoration(labelText: "Hash Method"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                try {
                  final options = PasswordOptions(
                    service: _serviceController.text,
                    passphrase: _passphraseController.text,
                    username: _usernameController.text,
                    year: _yearController.text,
                    length: _length.toInt(),
                    useUppercase: _useUppercase,
                    useNumbers: _useNumbers,
                    useSymbols: _useSymbols, // respeita a opção
                    method: _method,
                  );

                  setState(() {
                    _generatedPassword = _controller.generatePassword(options);
                  });
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Erro: $e")));
                }
              },
              child: const Text("Generate Password"),
            ),
            const SizedBox(height: 20),
            SelectableText(
              _generatedPassword.isEmpty
                  ? "Generated password will appear here"
                  : _generatedPassword,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (_generatedPassword.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  _controller.copyToClipboard(_generatedPassword);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Password copied to clipboard!"),
                    ),
                  );
                },
                child: const Text("Copy Password"),
              ),
          ],
        ),
      ),
    );
  }
}
