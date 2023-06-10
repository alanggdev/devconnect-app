import 'package:dev_connect_app/features/post/data/datasources/post_remote.dart';
import 'package:dev_connect_app/features/post/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDatasource postDatasource;

  PostRepositoryImpl({required this.postDatasource});

  @override
  Future<String> updatePost(int postid, int userid) async {
    return await postDatasource.updatePost(postid, userid);
  }
}