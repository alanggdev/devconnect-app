import 'package:dev_connect_app/features/post/domain/entities/comment.dart';
import 'package:dev_connect_app/features/post/domain/repositories/post_repository.dart';

class GetPostCommentsUseCase {
  final PostRepository postRepository;

  GetPostCommentsUseCase(this.postRepository);

  Future<List<Comment>> execute(int postid) async {
    return await postRepository.getPostComments(postid);
  }
}
