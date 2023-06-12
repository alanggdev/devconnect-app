import 'package:dev_connect_app/features/profile/domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel(
      {required int id,
      required String avatarURL,
      required String description,
      required String status,
      required dynamic user,
      required int userId,
      required dynamic followers,
      required dynamic following})
      : super(
            id: id,
            avatarURL: avatarURL,
            description: description,
            status: status,
            user: user,
            userId: userId,
            followers: followers,
            following: following);

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        id: json['id'],
        avatarURL: json['user_avatar'],
        description: json['user_description'],
        status: json['user_status'],
        user: json['user'],
        userId: json['user_profile'],
        followers: json['user_followers'],
        following: json['user_following']);
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
