import 'package:dev_connect_app/features/profile/data/datasources/profile_remote.dart';
import 'package:dev_connect_app/features/profile/data/models/profile_model.dart';
import 'package:dev_connect_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository{
  final ProfileDatasource profileDatasource;

  ProfileRepositoryImpl({required this.profileDatasource});

  @override
  Future<ProfileModel> getOwnProfile() async {
    return await profileDatasource.getOwnProfile();
  }
}