import 'package:dev_connect_app/features/profile/domain/entities/profile.dart';
import 'package:dev_connect_app/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository profileRepository;

  GetProfileUseCase(this.profileRepository);

  Future<Profile> execute(int userid) async {
    return await profileRepository.getProfile(userid);
  }
}
