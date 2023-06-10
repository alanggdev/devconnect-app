import 'package:dev_connect_app/features/post/domain/repositories/post_repository.dart';

class UpdatePostUseCase {
  final PostRepository postRepository;

  UpdatePostUseCase(this.postRepository);

  Future<String> execute(int postid, int userid) async {
    return await postRepository.updatePost(postid, userid);
  }
}
