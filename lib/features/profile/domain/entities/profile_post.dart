class ProfilePost {
  final int id;
  final dynamic userAuthor;
  final List<dynamic> postLikes;
  final String description;
  final String date;
  final String? postMediaRUL;

  ProfilePost({
    required this.id,
    required this.userAuthor,
    required this.postLikes,
    required this.description,
    required this.date,
    this.postMediaRUL
  });
}
