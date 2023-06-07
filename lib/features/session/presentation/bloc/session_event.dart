part of 'session_bloc.dart';

abstract class SessionEvent {}

class LogIn extends SessionEvent {
  final String username;
  final String password;

  LogIn({required this.username, required this.password});
}

class Register extends SessionEvent {
  final String username;
  final String email;
  final String password;
  final String firstname;
  final String lastname;

  final File avatar;
  final String description;
  final String status;

  Register(
      {required this.username,
      required this.email,
      required this.password,
      required this.firstname,
      required this.lastname,
      required this.avatar,
      required this.description,
      required this.status});
}
