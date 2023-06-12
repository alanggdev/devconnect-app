import 'package:dev_connect_app/features/post/data/datasources/post_remote.dart';
import 'package:dev_connect_app/features/post/data/models/comment_model.dart';
import 'package:dev_connect_app/features/post/data/models/post_model.dart';
import 'package:dev_connect_app/features/post/domain/entities/comment.dart';
import 'package:dev_connect_app/features/post/domain/entities/post.dart';
import 'package:dev_connect_app/features/post/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDatasource postDatasource;

  PostRepositoryImpl({required this.postDatasource});

  @override
  Future<String> updatePost(int postid, int userid) async {
    return await postDatasource.updatePost(postid, userid);
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    return await postDatasource.getAllPosts();
  }

  @override
  Future<PostModel> getPostDetail(int postid) async {
    return await postDatasource.getPostDetail(postid);
  }

  @override
  Future<List<CommentModel>> getPostComments(int postid) async {
    return await postDatasource.getPostComments(postid);
  }

  @override
  Future<String> createComment(Comment commentData) async {
    return await postDatasource.createComment(commentData);
  }

  @override
  Future<List<PostModel>> createPost(Post postData) async {
    return await postDatasource.createPost(postData);
  }
}
