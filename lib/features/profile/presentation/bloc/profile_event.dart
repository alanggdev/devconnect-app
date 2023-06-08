part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class GetProfile extends ProfileEvent {
  final int userid;

  GetProfile({required this.userid});
}