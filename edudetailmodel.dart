class UserDetails {
  final int userId;
  final String userEmail;
  final String userName;
  final String userMob;
  final String gender;
  final String position;

  UserDetails({
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.userMob,
    required this.gender,
    required this.position,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      userId: json['user_id'],
      userEmail: json['user_email'],
      userName: json['user_name'],
      userMob: json['user_mob'],
      gender: json['gender'],
      position: json['position'],
    );
  }
}

class EducationDetails {
  final String per10th;
  final String passingYear10th;
  final String per12th;
  final String passingYear12th;
  final String diplomaPer;
  final String diplomaPassingYear;
  final String ugCgpa;
  final String ugPassingYear;
  final String pgCgpa;
  final String pgPassingYear;
  final bool registration;
  final bool passport;

  EducationDetails({
    required this.per10th,
    required this.passingYear10th,
    required this.per12th,
    required this.passingYear12th,
    required this.diplomaPer,
    required this.diplomaPassingYear,
    required this.ugCgpa,
    required this.ugPassingYear,
    required this.pgCgpa,
    required this.pgPassingYear,
    required this.registration,
    required this.passport,
  });

  factory EducationDetails.fromJson(Map<String, dynamic> json) {
    return EducationDetails(
      per10th: json['per_10th'] ?? '',
      passingYear10th: json['passing_year_10th'] ?? '',
      per12th: json['per_12th'] ?? '',
      passingYear12th: json['passing_year_12th'] ?? '',
      diplomaPer: json['diploma_per'] ?? '',
      diplomaPassingYear: json['diploma_passing_year'] ?? '',
      ugCgpa: json['ug_cgpa'] ?? '',
      ugPassingYear: json['ug_passing_year'] ?? '',
      pgCgpa: json['pg_cgpa'] ?? '',
      pgPassingYear: json['pg_passing_year'] ?? '',
      registration: json['registration'] == 1,
      passport: json['passport'] == 1,
    );
  }
}
