import 'package:dev_connect_app/features/post/domain/entities/post.dart';
import 'package:dev_connect_app/features/post/domain/repositories/post_repository.dart';

class GetAllPostsUseCase {
  final PostRepository postRepository;

  GetAllPostsUseCase(this.postRepository);

  Future<List<Post>> execute() async {
    return await postRepository.getAllPosts();
  }
}
