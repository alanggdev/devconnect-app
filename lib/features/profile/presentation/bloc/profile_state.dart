part of 'profile_bloc.dart';

abstract class ProfileState {}

class InitialState extends ProfileState {}

class LoadingProfile extends ProfileState{}

class LoadedProfile extends ProfileState{
  final Profile profile;

  LoadedProfile({required this.profile});
}

class Error extends ProfileState {
  final String error;

  Error({required this.error});
}
