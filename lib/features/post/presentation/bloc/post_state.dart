part of 'post_bloc.dart';

abstract class PostState {}

class LoadingFollowingPosts extends PostState {}

class LoadedFollowingPosts extends PostState {
  List<Post> followingPosts;

  LoadedFollowingPosts({required this.followingPosts});
}

class InitialState extends PostState {}

class UpdatingPost extends PostState {}

class UpdatedPostByLike extends PostState {
  final String status;

  UpdatedPostByLike({required this.status});
}

class LoadingPublicPosts extends PostState {}

class LoadedPublicPosts extends PostState {
  List<Post> publicPosts;

  LoadedPublicPosts({required this.publicPosts});
}

class LoadingDetailPost extends PostState {}

class LoadedDetailPost extends PostState {
  final Post post;
  final List<Comment> comments;

  LoadedDetailPost({required this.post, required this.comments});
}

class CreatingComment extends PostState {}

class CreatedComment extends PostState {
  final String statusComment;

  CreatedComment({required this.statusComment});
}

class CreatingPost extends PostState {}

class CreatedPost extends PostState {
  List<Post> publicPosts;

  CreatedPost({required this.publicPosts});
}

class SearchingUser extends PostState {}

class UserFound extends PostState {
  List<dynamic> users;

  UserFound({required this.users});
}

class Error extends PostState {
  final String error;

  Error({required this.error});
}
