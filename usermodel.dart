class User {
  final String userId;
  final String userEmail;
  final String userName;
  final String userMob;
  final String gender;
  final String position;
  final String profilePhoto;

  User({
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.userMob,
    required this.gender,
    required this.position,
    required this.profilePhoto,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'].toString(),  // Ensure it's a String
      userEmail: json['user_email'] ?? '',  // Handle possible null value
      userName: json['user_name'] ?? '',
      userMob: json['user_mob'] ?? '',
      gender: json['gender'] ?? '',
      position: json['position'] ?? '',
      profilePhoto: json['profile_photo'] ?? '',
    );
  }
}
