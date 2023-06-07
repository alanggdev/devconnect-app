part of 'session_bloc.dart';

abstract class SessionState {}

class InitialState extends SessionState {}

class SigningIn extends SessionState {}

class SignedIn extends SessionState {
  final String signInStatus;

  SignedIn({required this.signInStatus});
}

class SigningUp extends SessionState {}

class SignedUp extends SessionState {
  final String signUpStatus;

  SignedUp({required this.signUpStatus});
}

class Error extends SessionState {
  final String error;

  Error({required this.error});
}
