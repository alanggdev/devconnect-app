import 'package:dev_connect_app/features/profile/data/datasources/profile_remote.dart';
import 'package:dev_connect_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:dev_connect_app/features/profile/domain/usecases/get_profile.dart';
import 'package:dev_connect_app/features/session/data/datasources/session_remote.dart';
import 'package:dev_connect_app/features/session/data/repositories/session_repository_impl.dart';
import 'package:dev_connect_app/features/session/domain/usecases/sign_in.dart';
import 'package:dev_connect_app/features/session/domain/usecases/sign_up.dart';

class UseCaseConfig {
  SignInDatasourceImpl? signInDatasourceImpl;
  SignInRepositoryImpl? signInRepositoryImpl;
  SignInUseCase? signInUseCase;

  SignUpDatasourceImpl? signUpDatasourceImpl;
  SignUpRepositoryImpl? signUpRepositoryImpl;
  SignUpUseCase? signUpUseCase;

  ProfileDatasourceImp? profileDatasourceImp;
  ProfileRepositoryImpl? profileRepositoryImpl;
  GetProfileUseCase? getProfileUseCase;

  UseCaseConfig() {
    signInDatasourceImpl = SignInDatasourceImpl();
    signInRepositoryImpl = SignInRepositoryImpl(signInDatasource: signInDatasourceImpl!);
    signInUseCase = SignInUseCase(signInRepositoryImpl!);

    signUpDatasourceImpl = SignUpDatasourceImpl();
    signUpRepositoryImpl = SignUpRepositoryImpl(signUpDatasource: signUpDatasourceImpl!);
    signUpUseCase = SignUpUseCase(signUpRepositoryImpl!);

    profileDatasourceImp = ProfileDatasourceImp();
    profileRepositoryImpl = ProfileRepositoryImpl(profileDatasource: profileDatasourceImp!);
    getProfileUseCase = GetProfileUseCase(profileRepositoryImpl!);
  }
}
