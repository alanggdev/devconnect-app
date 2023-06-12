import 'package:dev_connect_app/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository profileRepository;

  UpdateProfileUseCase(this.profileRepository);

  Future<void> execute(int profileid, int userid, int profileuserid) async {
    return await profileRepository.updateProfile(profileid, userid, profileuserid);
  }
}
