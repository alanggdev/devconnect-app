part of 'post_bloc.dart';

abstract class PostEvent {}

class CreatePost extends PostEvent {
  final int userid;
  final String description;
  final String date;
  final File? mediaFile;

  CreatePost(
      {required this.userid, required this.description, required this.date, this.mediaFile});
}

class LikePost extends PostEvent {
  final int postid;
  final int userid;

  LikePost({required this.postid, required this.userid});
}

class GetPublicPosts extends PostEvent {}

class GetDetailPost extends PostEvent {
  final int postid;

  GetDetailPost({required this.postid});
}

class CreateComment extends PostEvent {
  final int postid;
  final int userid;
  final String description;
  final String date;

  CreateComment(
      {required this.postid,
      required this.userid,
      required this.description,
      required this.date});
}
