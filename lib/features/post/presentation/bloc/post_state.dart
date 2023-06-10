part of 'post_bloc.dart';

abstract class PostState {}

class InitialState extends PostState {}

class UpdatingPost extends PostState {}

class UpdatedPostByLike extends PostState {
  final String status;

  UpdatedPostByLike({required this.status});
}

class Error extends PostState {
  final String error;

  Error({required this.error});
}