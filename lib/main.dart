import 'package:flutter/material.dart';
import '../views/user_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Password Generator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PasswordView(),
    );
  }
}
