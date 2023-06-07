import 'package:dev_connect_app/features/session/domain/entities/sign_in.dart';

class SignInModel extends SignIn {
  SignInModel({required String username, required String password})
      : super(username: username, password: password);

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(username: json['username'], password: json['password']);
  }

  static Map<String, dynamic> fromEntityToJson(SignIn signin) {
    return {'username': signin.username, 'password': signin.password};
  }
}
