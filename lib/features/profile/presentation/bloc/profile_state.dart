part of 'profile_bloc.dart';

abstract class ProfileState {}

class InitialState extends ProfileState {}

class LoadingProfile extends ProfileState {}

class LoadedProfile extends ProfileState {
  final Profile profile;
  final List<ProfilePost> profilePosts;

  LoadedProfile({required this.profile, required this.profilePosts});
}

class Liked extends ProfileState {
  final bool liked;

  Liked({required this.liked});
}

class Error extends ProfileState {
  final String error;

  Error({required this.error});
}
