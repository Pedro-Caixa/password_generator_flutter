import 'package:aula_05/controllers/user_controller.dart';
import 'package:flutter/material.dart';

class UserView extends StatefulWidget {
  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  final UserController _controller = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Name: ${_controller.user.name}"),
            Text("Age: ${_controller.user.age}"),
            Text("Email: ${_controller.user.email}"),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controller.updateUser("Jane Doe", 30, 'jane@gmail.com');
                });
              },
              child: Text("Update User"),
            ),
          ],
        ),
      ),
    );
  }
}
