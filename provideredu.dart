import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flygaulf/Model/educationmodel.dart';
import 'package:http/http.dart' as http;

class EducationProvider with ChangeNotifier {
  Future<void> submitForm(EducationDetails details) async {
    log(details.selectedGender!);
    log(details.currentPosition);
    final url = Uri.parse('http://192.168.1.19/fgica/api_insert_edudetails.php');
    try {
      final response = await http.post(
        url,
        body: {
          'name': details.name,
          'email': details.email,
          'mob': details.mobile,
          'per_10th': details.tenthPercentage,
          'passing_year_10th': details.tenthYear,
          'per_12th': details.twelthPercentage,
          'passing_year_12th': details.twelthYear,
          'diploma_per': details.diplomaCgpa,
          'diploma_passing_year': details.diplomaYear,
          'ug_cgpa': details.graduationCgpa,
          'ug_passing_year': details.graduationYear,
          'pg_cgpa': details.postGraduationCgpa,
          'pg_passing_year': details.postGraduationYear,
          'registration': details.registration ? 'Yes' : 'No',
          'passport': details.passport ? 'Yes' : 'No',
          'position': details.currentPosition,
          'gender':details.selectedGender
        },
      );
      if (response.statusCode == 200) {
        // Handle success
        notifyListeners();
        log(response.body);
      } else {
        throw Exception('Failed to submit form');
      }
    } catch (error) {
      rethrow;
    }
  }
}
