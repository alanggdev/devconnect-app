part of 'post_bloc.dart';

abstract class PostEvent {}

class LikePost extends PostEvent{
  final int postid;
  final int userid;

  LikePost({required this.postid, required this.userid});
}