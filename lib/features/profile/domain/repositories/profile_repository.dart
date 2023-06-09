import 'package:dev_connect_app/features/profile/domain/entities/profile.dart';
import 'package:dev_connect_app/features/profile/domain/entities/profile_post.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile(int userid);
  Future<List<ProfilePost>> getProfilePosts(int userid);
}