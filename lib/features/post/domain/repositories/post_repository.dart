import 'package:dev_connect_app/features/post/domain/entities/comment.dart';
import 'package:dev_connect_app/features/post/domain/entities/post.dart';

abstract class PostRepository {
  Future<String> updatePost(int postid, int userid);
  Future<List<Post>> getAllPosts();
  Future<Post> getPostDetail(int postid);
  Future<List<Comment>> getPostComments(int postid);
  Future<String> createComment(Comment commentData);
  Future<List<Post>> createPost(Post postData);
}