class Profile {
  final int id;
  final String avatarURL;
  final String description;
  final String status;
  final dynamic user;
  final int userId;
  final dynamic followers;
  final dynamic following;

  Profile({
    required this.id,
    required this.avatarURL,
    required this.description,
    required this.status,
    required this.user,
    required this.userId,
    required this.followers,
    required this.following
  });
}
