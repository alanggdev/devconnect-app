// import 'package:dev_connect_app/features/post/domain/entities/post.dart';

abstract class PostRepository {
  Future<String> updatePost(int postid, int userid);
  // Future<String> createPost(Post postData);
  // Future<String> deletePost(int postid);
  // Future<List<Post>> getAllPosts();
  // Future<List<Post>> getPollowingPosts();
  // Future<Post> getPostDetail(int postid);
}