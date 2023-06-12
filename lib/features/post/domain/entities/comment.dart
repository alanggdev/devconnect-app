class Comment {
  final int? id;
  final int postComment;
  final int author;
  final dynamic userAuthor;
  final String description;
  final String date;

  Comment({
    this.id,
    required this.postComment,
    required this.author,
    this.userAuthor,
    required this.description,
    required this.date,
  });
}
