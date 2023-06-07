import 'package:dev_connect_app/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getOwnProfile();
}