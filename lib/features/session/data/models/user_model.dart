import 'package:dev_connect_app/features/session/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required String access, required String refresh})
      : super(access: access, refresh: refresh);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(access: json['access'], refresh: json['refresh']);
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(access: user.access, refresh: user.refresh);
  }
}
