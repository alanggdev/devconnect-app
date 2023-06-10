import 'package:dev_connect_app/features/profile/domain/entities/profile_post.dart';

class ProfilePostModel extends ProfilePost {
  ProfilePostModel(
      {required int id,
      required dynamic userAuthor,
      required List<dynamic> postLikes,
      required String description,
      required String date,
      String? postMediaRUL})
      : super(
            id: id,
            userAuthor: userAuthor,
            postLikes: postLikes,
            description: description,
            date: date,
            postMediaRUL: postMediaRUL);

  factory ProfilePostModel.fromJson(Map<String, dynamic> json) {
    return ProfilePostModel(
        id: json['id'],
        userAuthor: json['user_author'],
        postLikes: json['likes'],
        description: json['description'],
        date: json['date']);
  }

  factory ProfilePostModel.fromJsonMedia(Map<String, dynamic> json) {
    return ProfilePostModel(
        id: json['id'],
        userAuthor: json['user_author'],
        postLikes: json['likes'],
        description: json['description'],
        date: json['date'],
        postMediaRUL: json['media']);
  }

  @override
  String toString() {
    return 'ProfilePostModel{id: $id, userAuthor: $userAuthor, postLikes: $postLikes, description: $description, date: $date, media $postMediaRUL}';
  }
}
