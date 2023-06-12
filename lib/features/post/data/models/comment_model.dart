import 'package:dev_connect_app/features/post/domain/entities/comment.dart';

class CommentModel extends Comment {
  CommentModel({
    int? id,
    required int postComment,
    required int author,
    dynamic userAuthor,
    required String description,
    required String date,
  }) : super(
          id: id,
          postComment: postComment,
          author: author,
          userAuthor: userAuthor,
          description: description,
          date: date,
        );

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      userAuthor: json['user_author'],
      description: json['description'],
      date: json['date'],
      postComment: json['post_comment'],
      author: json['author'],
    );
  }

  static Map<String, dynamic> fromEntityToJson(CommentModel comment) {
    return {
      'post_comment': comment.postComment,
      'author': comment.author,
      'description': comment.description,
      'date': comment.date
    };
  }

  @override
  String toString() {
    return 'CommentModel{'
        'id: $id, '
        'postComment: $postComment, '
        'author: $author, '
        'userAuthor: $userAuthor, '
        'description: $description, '
        'date: $date'
        '}';
  }
}
