import 'package:dev_connect_app/features/session/domain/entities/sign_in.dart';
import 'package:dev_connect_app/features/session/domain/repositories/session_repository.dart';

class SignInUseCase {
  final SignInRepository signInRepository;

  SignInUseCase(this.signInRepository);

  Future<String> execute(SignIn signInData) async {
    return await signInRepository.login(signInData);
  }
}