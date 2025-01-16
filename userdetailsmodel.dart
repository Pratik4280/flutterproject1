class UserDetails {
  final String userId;
  final String userName;
  final String userEmail;
  final String userMob;
  final String gender;
  final String position;
  final String status;
  final String createdOn;

  UserDetails({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userMob,
    required this.gender,
    required this.position,
    required this.status,
    required this.createdOn,
  });

  // Factory constructor to convert JSON into UserDetails object
  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      userId: json['user_id'].toString(),
      userName: json['user_name'],
      userEmail: json['user_email'],
      userMob: json['user_mob'],
      gender: json['gender'],
      position: json['position'],
      status: json['status'],
      createdOn: json['created_on'],
    );
  }
}
