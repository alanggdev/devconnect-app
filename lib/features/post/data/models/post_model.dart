import 'dart:io';

import 'package:dev_connect_app/features/post/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required int author,
    int? id,
    dynamic userAuthor,
    String? mediaURL,
    List<dynamic>? likes,
    String? description,
    String? date,
    File? mediaFile,
  }) : super(
          author: author,
          id: id,
          userAuthor: userAuthor,
          mediaURL: mediaURL,
          likes: likes,
          description: description,
          date: date,
          mediaFile: mediaFile,
        );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userAuthor: json['user_author'],
      description: json['description'],
      // media
      date: json['date'],
      author: json['author'],
      likes: json['likes'],
    );
  }

  factory PostModel.fromJsonMedia(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userAuthor: json['user_author'],
      description: json['description'],
      mediaURL: json['media'],
      date: json['date'],
      author: json['author'],
      likes: json['likes'],
    );
  }

  static Map<String, dynamic> fromEntityToJsonLikes(PostModel profile) {
    return {'author': profile.author, 'likes': profile.likes};
  }

  static Map<String, dynamic> fromEntityToJsonCreate(Post profile) {
    return {
      'author': profile.author,
      'description': profile.description,
      'date': profile.date
    };
  }

  static Map<String, dynamic> fromEntityToJsonCreateMedia(Post profile) {
    return {
      'author': profile.author,
      'description': profile.description,
      'date': profile.date,
      'media': profile.mediaFile
    };
  }

  @override
  String toString() {
    return 'PostModel(author: $author, id: $id, userAuthor: $userAuthor, mediaURL: $mediaURL, likes: $likes, description: $description, date: $date, mediaFile: $mediaFile)';
  }
}
