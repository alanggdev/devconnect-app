import 'dart:io';

import 'package:dev_connect_app/features/session/domain/entities/sign_up.dart';

class SignUpModel extends SignUp {
  SignUpModel(
      {required String username,
      required String email,
      required String firstname,
      required String lastname,
      required String password,
      required File avatar,
      required String description,
      required String status,
      required int userProfile})
      : super(
            username: username,
            email: email,
            firstname: firstname,
            lastname: lastname,
            password: password,
            avatar: avatar,
            description: description,
            status: status);

  static Map<String, dynamic> fromEntityToJsonUser(SignUp signup) {
    return {
      'username': signup.username,
      'email': signup.email,
      'password1': signup.password,
      'password2': signup.password,
      'first_name': signup.firstname,
      'last_name': signup.lastname
    };
  }

  static Map<String, dynamic> fromEntityToJsonProfile(SignUp signup) {
    return {
      'user_avatar': signup.avatar,
      'user_description': signup.description,
      'user_status': signup.status
    };
  }
}
