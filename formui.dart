import 'package:flutter/material.dart';
import 'package:flygaulf/Controller/formcontroller.dart';
import 'package:provider/provider.dart';

class EducationalFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<FormController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Educational Details Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              // Name Field
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  errorText: controller.isNameValid ? null : 'Please enter a name',
                ),
              ),
              // Mobile Number Field
              TextField(
                controller: controller.mobController,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  errorText: controller.isMobValid ? null : 'Enter a valid mobile number',
                ),
                keyboardType: TextInputType.phone,
              ),
              // Email Field
              TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  errorText: controller.isEmailValid ? null : 'Enter a valid email address',
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              // Gender Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Gender:'),
                  Radio<String>(
                    value: 'Male',
                    groupValue: controller.gender,
                    onChanged: (value) {
                      controller.gender = value!;
                      controller.notifyListeners();
                    },
                  ),
                  Text('Male'),
                  Radio<String>(
                    value: 'Female',
                    groupValue: controller.gender,
                    onChanged: (value) {
                      controller.gender = value!;
                      controller.notifyListeners();
                    },
                  ),
                  Text('Female'),
                ],
              ),
              // 10th Percentage Field
              TextField(
                controller: controller.per10thController,
                decoration: InputDecoration(labelText: '10th Percentage'),
              ),
              // 12th Percentage Field
              TextField(
                controller: controller.per12thController,
                decoration: InputDecoration(labelText: '12th Percentage'),
              ),
              // Diploma Percentage Field
              TextField(
                controller: controller.diplomaPerController,
                decoration: InputDecoration(labelText: 'Diploma Percentage'),
              ),
              // UG CGPA Field
              TextField(
                controller: controller.ugCgpaController,
                decoration: InputDecoration(labelText: 'UG CGPA'),
              ),
              // PG CGPA Field
              TextField(
                controller: controller.pgCgpaController,
                decoration: InputDecoration(labelText: 'PG CGPA'),
              ),
              // Registration and Passport Fields
              Row(
                children: [
                  Text('Registration:'),
                  Switch(
                    value: controller.registration,
                    onChanged: (value) {
                      controller.registration = value;
                      controller.notifyListeners();
                    },
                  ),
                  Text('Passport:'),
                  Switch(
                    value: controller.passport,
                    onChanged: (value) {
                      controller.passport = value;
                      controller.notifyListeners();
                    },
                  ),
                ],
              ),
              // Position Field
              TextField(
                controller: controller.positionController,
                decoration: InputDecoration(labelText: 'Current Position'),
              ),
              // Submit Button
              ElevatedButton(
                onPressed: () {
                  controller.submitForm(context);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
