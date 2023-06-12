part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class GetProfile extends ProfileEvent {
  final int userid;

  GetProfile({required this.userid});
}

class FollowProfile extends ProfileEvent {
  final int profileid, userid, profileuserid;

  FollowProfile({required this.profileid, required this.userid, required this.profileuserid});
}