// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flygaulf/Model/edudetailmodel.dart';
// import 'package:flygaulf/Model/userdetailsmodel.dart';
// import 'package:http/http.dart' as http;

// class ProfileProvider with ChangeNotifier {
//   UserDetails? _userDetails;
//   EducationDetails1? _educationDetails;
//   bool _isEducationTapped = false;

//   UserDetails? get userDetails => _userDetails;
//   EducationDetails1? get educationDetails => _educationDetails;
//   bool get isEducationTapped => _isEducationTapped;

//   // Function to toggle the visibility of education details
//   void toggleEducationDetails() {
//     _isEducationTapped = !_isEducationTapped;
//     notifyListeners();
//   }

//   // Function to fetch user and education details
//   Future<void> fetchProfileData(int userId) async {
  
//     // Call the API to fetch user details and education details
//     final response = await http.get(Uri.parse('http://192.168.1.19/fgica/api_user_details.php?user_id=$userId'));

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);

//       // Parse the response and update the state
//       _userDetails = UserDetails.fromJson(data['user_details']);
//       _educationDetails = educationDetails.fromJson(data['education_details']);
//       notifyListeners();
//     } else {
//       throw Exception('Failed to load profile data');
//     }
//   }
// }
