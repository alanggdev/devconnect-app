import 'package:dev_connect_app/features/post/domain/entities/post.dart';
import 'package:dev_connect_app/features/post/domain/repositories/post_repository.dart';

class GetDetailPostUseCase {
  final PostRepository postRepository;

  GetDetailPostUseCase(this.postRepository);

  Future<Post> execute(int postid) async {
    return await postRepository.getPostDetail(postid);
  }
}
