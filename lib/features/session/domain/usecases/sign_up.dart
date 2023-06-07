import 'package:dev_connect_app/features/session/domain/entities/sign_up.dart';
import 'package:dev_connect_app/features/session/domain/repositories/session_repository.dart';

class SignUpUseCase {
  final SignUpRepository signUpRepository;

  SignUpUseCase(this.signUpRepository);

  Future<String> execute(SignUp signUpData) async {
    return await signUpRepository.register(signUpData);
  }
}