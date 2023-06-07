import 'dart:io';

class SignUp {
  final String username;
  final String email;
  final String firstname;
  final String lastname;
  final String password;
  
  final File avatar;
  final String description;
  final String status;

  SignUp({
    required this.username,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.password,
    required this.avatar,
    required this.description,
    required this.status
  });
}
