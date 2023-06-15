import 'package:dev_connect_app/features/post/domain/repositories/post_repository.dart';

class SearchUserUseCase {
  final PostRepository postRepository;

  SearchUserUseCase(this.postRepository);

  Future<List<dynamic>> execute(String username) async {
    return await postRepository.searchUser(username);
  }
}
