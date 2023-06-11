part of 'post_bloc.dart';

abstract class PostEvent {}

class LikePost extends PostEvent{
  final int postid;
  final int userid;

  LikePost({required this.postid, required this.userid});
}

class GetPublicPosts extends PostEvent {}

class GetDetailPost extends PostEvent {
  final int postid;

  GetDetailPost({required this.postid});
}