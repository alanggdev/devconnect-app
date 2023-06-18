import 'dart:io';

import 'package:dev_connect_app/features/post/domain/entities/comment.dart';
import 'package:dev_connect_app/features/post/domain/entities/post.dart';
import 'package:dev_connect_app/features/post/domain/usecases/create_comment.dart';
import 'package:dev_connect_app/features/post/domain/usecases/create_post.dart';
import 'package:dev_connect_app/features/post/domain/usecases/get_all_posts.dart';
import 'package:dev_connect_app/features/post/domain/usecases/get_detail_post.dart';
import 'package:dev_connect_app/features/post/domain/usecases/get_following_posts.dart';
import 'package:dev_connect_app/features/post/domain/usecases/get_post_comments.dart';
import 'package:dev_connect_app/features/post/domain/usecases/search_user.dart';
import 'package:dev_connect_app/features/post/domain/usecases/update_post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final UpdatePostUseCase updatePostUseCase;
  final GetAllPostsUseCase getAllPostsUseCase;
  final GetDetailPostUseCase getDetailPostUseCase;
  final GetPostCommentsUseCase getPostCommentsUseCase;
  final CreateCommentUseCase createCommentUseCase;
  final CreatePostUseCase createPostUseCase;
  final SearchUserUseCase searchUserUseCase;
  final GetFollowingPostsUseCase getFollowingPostsUseCase;

  PostBloc(
      {required this.updatePostUseCase,
      required this.getAllPostsUseCase,
      required this.getDetailPostUseCase,
      required this.getPostCommentsUseCase,
      required this.createCommentUseCase,
      required this.createPostUseCase,
      required this.searchUserUseCase,
      required this.getFollowingPostsUseCase})
      : super(InitialState()) {
    on<PostEvent>((event, emit) async {
      if (event is GetFollowingPosts) {
        try {
          emit(LoadingFollowingPosts());
          List<Post> followingPosts = await getFollowingPostsUseCase.execute(event.userid);
          emit(LoadedFollowingPosts(followingPosts: followingPosts));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } else if (event is SearchUser) {
        try {
          emit(SearchingUser());
          List<dynamic> users = await searchUserUseCase.execute(event.username);
          emit(UserFound(users: users));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } else if (event is LikePost) {
        try {
          // emit(UpdatingPost());
          await updatePostUseCase.execute(event.postid, event.userid);
          // emit(UpdatedPostByLike(status: status));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } else if (event is GetPublicPosts) {
        try {
          emit(LoadingPublicPosts());
          List<Post> publicPosts = await getAllPostsUseCase.execute();
          emit(LoadedPublicPosts(publicPosts: publicPosts));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } else if (event is GetDetailPost) {
        try {
          emit(LoadingDetailPost());
          Post postDetail = await getDetailPostUseCase.execute(event.postid);
          List<Comment> postComments =
              await getPostCommentsUseCase.execute(event.postid);
          emit(LoadedDetailPost(post: postDetail, comments: postComments));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } else if (event is CreateComment) {
        try {
          emit(CreatingComment());
          Comment commentData = Comment(
              postComment: event.postid,
              author: event.userid,
              description: event.description,
              date: event.date);
          String status = await createCommentUseCase.execute(commentData);
          emit(CreatedComment(statusComment: status));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } else if (event is CreatePost) {
        try {
          // emit(CreatingPost());
          Post postData = Post(
              author: event.userid,
              description: event.description,
              date: event.date,
              mediaFile: event.mediaFile);
          await createPostUseCase.execute(postData);
          // emit(CreatedPost(publicPosts: publicPost));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}
