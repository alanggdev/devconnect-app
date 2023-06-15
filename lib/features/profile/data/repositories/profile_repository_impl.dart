import 'package:dev_connect_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:dev_connect_app/features/profile/data/datasources/profile_remote.dart';
import 'package:dev_connect_app/features/profile/data/models/profile_model.dart';
import 'package:dev_connect_app/features/profile/data/models/profile_post_model.dart';

class ProfileRepositoryImpl implements ProfileRepository{
  final ProfileDatasource profileDatasource;

  ProfileRepositoryImpl({required this.profileDatasource});

  @override
  Future<ProfileModel> getProfile(int userid) async {
    return await profileDatasource.getProfile(userid);
  }

  @override
  Future<List<ProfilePostModel>> getProfilePosts(int userid) async {
    return await profileDatasource.getProfilePosts(userid);
  }

  @override
  Future<void> updateProfile(int profileid, int userid, int profileuserid) async {
    return await profileDatasource.updateProfile(profileid, userid, profileid);
  }
}