import 'package:dev_connect_app/features/session/data/datasources/session_remote.dart';
import 'package:dev_connect_app/features/session/domain/entities/sign_in.dart';
import 'package:dev_connect_app/features/session/domain/entities/sign_up.dart';
import 'package:dev_connect_app/features/session/domain/repositories/session_repository.dart';

class SignInRepositoryImpl implements SignInRepository{
  final SignInDatasource signInDatasource;

  SignInRepositoryImpl({required this.signInDatasource});

  @override
  Future<String> login(SignIn signInData) async {
    return await signInDatasource.login(signInData);
  }
}

class SignUpRepositoryImpl implements SignUpRepository{
  final SignUpDatasource signUpDatasource;

  SignUpRepositoryImpl({required this.signUpDatasource});

  @override
  Future<String> register(SignUp signUpData) async {
    return await signUpDatasource.register(signUpData);
  }
}