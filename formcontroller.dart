import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormController extends ChangeNotifier {
  // Form field controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobController = TextEditingController();
  TextEditingController per10thController = TextEditingController();
  TextEditingController passingYear10thController = TextEditingController();
  TextEditingController per12thController = TextEditingController();
  TextEditingController passingYear12thController = TextEditingController();
  TextEditingController diplomaPerController = TextEditingController();
  TextEditingController diplomaPassingYearController = TextEditingController();
  TextEditingController ugCgpaController = TextEditingController();
  TextEditingController ugPassingYearController = TextEditingController();
  TextEditingController pgCgpaController = TextEditingController();
  TextEditingController pgPassingYearController = TextEditingController();
  TextEditingController positionController = TextEditingController();

  // Validation flags
  bool isNameValid = true;
  bool isMobValid = true;
  bool isEmailValid = true;
  bool isGenderSelected = false;
  bool isEducationValid = true;
  
  // Default values for registration and passport
  bool registration = false;
  bool passport = false;
  String gender = "Male"; // Default value

  // Form validation
  bool validateForm() {
    isNameValid = nameController.text.isNotEmpty;
    isMobValid = mobController.text.isNotEmpty && mobController.text.length == 10;
    isEmailValid = emailController.text.isNotEmpty && emailController.text.contains('@');
    isGenderSelected = gender.isNotEmpty;
    isEducationValid = per10thController.text.isNotEmpty &&
                       per12thController.text.isNotEmpty &&
                       diplomaPerController.text.isNotEmpty &&
                       ugCgpaController.text.isNotEmpty;

    notifyListeners();
    return isNameValid && isMobValid && isEmailValid && isGenderSelected && isEducationValid;
  }

  // Sending data to the server
  Future<void> submitForm(BuildContext context) async {
    if (validateForm()) {
      final url = 'http://192.168.1.19/fgica/api_insert_edudetails.php';
      try {
        final response = await http.post(Uri.parse(url), body: {
          'name': nameController.text,
          'email': emailController.text,
          'mob': mobController.text,
          'per_10th': per10thController.text,
          'passing_year_10th': passingYear10thController.text,
          'per_12th': per12thController.text,
          'passing_year_12th': passingYear12thController.text,
          'diploma_per': diplomaPerController.text,
          'diploma_passing_year': diplomaPassingYearController.text,
          'ug_cgpa': ugCgpaController.text,
          'ug_passing_year': ugPassingYearController.text,
          'pg_cgpa': pgCgpaController.text,
          'pg_passing_year': pgPassingYearController.text,
          'registration': registration ? '1' : '0',
          'passport': passport ? '1' : '0',
          'position': positionController.text,
          'gender': gender,
        });

        if (response.statusCode == 200) {
          log(response.body);
          Navigator.pushReplacementNamed(context, '/profile');
        } else {
          print('Error: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }
}
