import 'package:dev_connect_app/features/post/domain/entities/comment.dart';
import 'package:dev_connect_app/features/post/domain/repositories/post_repository.dart';

class CreateCommentUseCase {
  final PostRepository postRepository;

  CreateCommentUseCase(this.postRepository);

  Future<String> execute(Comment commentData) async {
    return await postRepository.createComment(commentData);
  }
}
