import 'package:dev_connect_app/features/profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel(
      {required int id,
      required String avatarURL,
      required String description,
      required String status,
      required dynamic user,
      required int userId})
      : super(
            id: id,
            avatarURL: avatarURL,
            description: description,
            status: status,
            user: user,
            userId: userId);

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        id: json['id'],
        avatarURL: json['user_avatar'],
        description: json['user_description'],
        status: json['user_status'],
        user: json['user'],
        userId: json['user_profile']);
  }

  static Map<String, dynamic> fromEntityToJson(Profile profile) {
    return {
      'id': profile.id,
      'user_avatar': profile.avatarURL,
      'user_description': profile.description,
      'user_status': profile.status,
      'user_profile': profile.userId
    };
  }
}
