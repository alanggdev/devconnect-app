import 'dart:io';

class Post {
  // required data
  final int author;

  // extra data to get
  final int? id;
  final dynamic userAuthor;
  final String? mediaURL;

  // data to post / update
  final List<dynamic>? likes;
  final String? description;
  final String? date;
  final File? mediaFile;

  Post({
    required this.author,
    this.id,
    this.userAuthor,
    this.mediaURL,
    this.likes,
    this.description,
    this.date,
    this.mediaFile
  });
}
