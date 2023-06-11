part of 'post_bloc.dart';

abstract class PostState {}

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

  LoadedDetailPost({required this.post});
}

class Error extends PostState {
  final String error;

  Error({required this.error});
}