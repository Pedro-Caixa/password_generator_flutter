import 'package:aula_05/models/user_model.dart';

class UserController {
  User user = User(name: 'Pedro', age: 20, email: 'pedro@gmail.com');

  void updateUser(String name, int age, String email) {
    user.name = name;
    user.age = age;
    user.email = email;
  }
}
