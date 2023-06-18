import 'package:dev_connect_app/features/post/domain/entities/post.dart';
import 'package:dev_connect_app/features/post/domain/repositories/post_repository.dart';

class GetFollowingPostsUseCase {
  final PostRepository postRepository;

  GetFollowingPostsUseCase(this.postRepository);

  Future<List<Post>> execute(int userid) async {
    return await postRepository.getFollowingPosts(userid);
  }
}
