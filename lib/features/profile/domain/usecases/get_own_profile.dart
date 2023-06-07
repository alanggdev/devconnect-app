import 'package:dev_connect_app/features/profile/domain/entities/profile.dart';
import 'package:dev_connect_app/features/profile/domain/repositories/profile_repository.dart';

class GetOwnProfileUseCase {
  final ProfileRepository profileRepository;

  GetOwnProfileUseCase(this.profileRepository);

  Future<Profile> execute() async {
    return await profileRepository.getOwnProfile();
  }
}
