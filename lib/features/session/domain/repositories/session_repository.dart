
import 'package:dev_connect_app/features/session/domain/entities/sign_in.dart';
import 'package:dev_connect_app/features/session/domain/entities/sign_up.dart';

abstract class SignUpRepository {
  Future<String> register(SignUp signUpData);
}

abstract class SignInRepository {
  Future<String> login(SignIn signInData);
}