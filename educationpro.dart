import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class EducationDetailsPage extends StatefulWidget {
  const EducationDetailsPage({super.key});
  @override
  _EducationDetailsPageState createState() => _EducationDetailsPageState();
}

class _EducationDetailsPageState extends State<EducationDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for educational fields
  final per10thController = TextEditingController();
  final passingYear10thController = TextEditingController();
  final per12thController = TextEditingController();
  final passingYear12thController = TextEditingController();
  final diplomaPerController = TextEditingController();
  final diplomaPassingYearController = TextEditingController();
  final ugCgpaController = TextEditingController();
  final ugPassingYearController = TextEditingController();
  final pgCgpaController = TextEditingController();
  final pgPassingYearController = TextEditingController();
  final registrationController = TextEditingController();
  final passportController = TextEditingController();

  Future<Map<String, dynamic>> fetchEducationDetails() async {
  final url = Uri.parse('http://192.168.1.19/fgica/api_user_details.php?user_id=27');
  try {
    final response = await http.get(url);
    log('Raw Response: ${response.body}'); // Log the raw response

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      log('Parsed JSON: $jsonResponse'); // Log the parsed JSON

      if (jsonResponse['status'] == 'success' && jsonResponse['data'] != null) {
        final educationDetails = jsonResponse['data'][0]['education_details'] ?? {};

        // Pre-fill the fields with data (ensure values are cast to String)
        per10thController.text = educationDetails['per_10th']?.toString() ?? '';
        passingYear10thController.text = educationDetails['passing_year_10th']?.toString() ?? '';
        per12thController.text = educationDetails['per_12th']?.toString() ?? '';
        passingYear12thController.text = educationDetails['passing_year_12th']?.toString() ?? '';
        diplomaPerController.text = educationDetails['diploma_per']?.toString() ?? '';
        diplomaPassingYearController.text = educationDetails['diploma_passing_year']?.toString() ?? '';
        ugCgpaController.text = educationDetails['ug_cgpa']?.toString() ?? '';
        ugPassingYearController.text = educationDetails['ug_passing_year']?.toString() ?? '';
        pgCgpaController.text = educationDetails['pg_cgpa']?.toString() ?? '';
        pgPassingYearController.text = educationDetails['pg_passing_year']?.toString() ?? '';
        registrationController.text = educationDetails['registration']?.toString() ?? '';
        passportController.text = educationDetails['passport']?.toString() ?? '';

        return educationDetails;
      } else {
        throw Exception('Invalid response structure');
      }
    } else {
      throw Exception('Failed to fetch data. HTTP Status: ${response.statusCode}');
    }
  } catch (e) {
    log('Error fetching data: $e');
    rethrow;
  }
}


 Future<void> updateEducationDetails() async {
  final url = Uri.parse('http://192.168.1.19/fgica/api_edit_education_details.php');

  try {
    // Ensure that all values being sent are of type String
    final response = await http.post(url, body: {
      'user_id': '27', // Ensure this is a string
      'per_10th': per10thController.text ?? '',  // Ensure no null values
      'passing_year_10th': passingYear10thController.text ?? '',
      'per_12th': per12thController.text ?? '',
      'passing_year_12th': passingYear12thController.text ?? '',
      'diploma_per': diplomaPerController.text ?? '',
      'diploma_passing_year': diplomaPassingYearController.text ?? '',
      'ug_cgpa': ugCgpaController.text ?? '',
      'ug_passing_year': ugPassingYearController.text ?? '',
      'pg_cgpa': pgCgpaController.text ?? '',
      'pg_passing_year': pgPassingYearController.text ?? '',
      'registration': registrationController.text ?? '',
      'passport': passportController.text ?? '',
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Education details updated successfully')),
        );
      } else {
        throw Exception('Failed to update education details');
      }
    } else {
      throw Exception('Failed to update education details. HTTP Status: ${response.statusCode}');
    }
  } catch (e) {
    log('Error updating education details: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error updating education details')),
    );
  }
}



  @override
  void initState() {
    super.initState();
    fetchEducationDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Education Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchEducationDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final educationDetails = snapshot.data;

            return Stack(
              children: [Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Education Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      _buildTextField('10th Percentage', per10thController),
                      _buildTextField('10th Passing Year', passingYear10thController),
                      _buildTextField('12th Percentage', per12thController),
                      _buildTextField('12th Passing Year', passingYear12thController),
                      _buildTextField('Diploma Percentage', diplomaPerController),
                      _buildTextField('Diploma Passing Year', diplomaPassingYearController),
                      _buildTextField('UG CGPA', ugCgpaController),
                      _buildTextField('UG Passing Year', ugPassingYearController),
                      _buildTextField('PG CGPA', pgCgpaController),
                      _buildTextField('PG Passing Year', pgPassingYearController),
                      _buildTextField('Registration (yes/no)', registrationController),
                      _buildTextField('Passport (yes/no)', passportController),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: updateEducationDetails,
                        child: const Text('Save Changes'),
                      ),
                    ],
                  ),
                ),
              ),
              ]
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
      
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
