import 'package:dev_connect_app/features/profile/domain/entities/profile_post.dart';
import 'package:dev_connect_app/features/profile/domain/repositories/profile_repository.dart';

class GetProfilePostsUseCase {
  final ProfileRepository profileRepository;

  GetProfilePostsUseCase(this.profileRepository);

  Future<List<ProfilePost>> execute(int userid) async {
    return await profileRepository.getProfilePosts(userid);
  }
}
