
// // ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:flygaulf/Controller/provideredu.dart';
// import 'package:flygaulf/Model/educationmodel.dart';
// import 'package:flygaulf/Profile.dart';
// import 'package:provider/provider.dart';


// class EducationFormScreen extends StatefulWidget {
//   const EducationFormScreen({super.key});

//   @override
//   _EducationFormScreenState createState() => _EducationFormScreenState();
// }

// class _EducationFormScreenState extends State<EducationFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _details = EducationDetails(
//     name: '',
//     email: '',
//     mobile: '',
//     tenthPercentage: '',
//     tenthYear: '',
//     twelthPercentage: '',
//     twelthYear: '',
//     diplomaCgpa: '',
//     diplomaYear: '',
//     graduationCgpa: '',
//     graduationYear: '',
//     postGraduationCgpa: '',
//     postGraduationYear: '',
//     currentPosition: '',
//     selectedGender: '',
//     registration: false,
//     passport: false,
//   );
//   final List<String> genders = ['Male', 'Female', 'Other'];

//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       try {
//         await Provider.of<EducationProvider>(context, listen: false)
//             .submitForm(_details);
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (context) => ProfilePage(details: _details,),
//           ),
//         );
//       } catch (error) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to submit form')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Educational Details')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Enter your Name'),
//                 onSaved: (value) => _details.name = value!,
//                 validator: (value) => value!.isEmpty ? 'Enter your name' : null,
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Enter your Email'),
//                 onSaved: (value) => _details.email = value!,
//                 validator: (value) =>
//                     value!.isEmpty ? 'Enter your email' : null,
//               ),
//                TextFormField(
//                 decoration: InputDecoration(labelText: 'Enter your Number'),
//                 onSaved: (value) => _details.mobile = value!,
//                 validator: (value) =>
//                     value!.isEmpty ? 'Enter your Mobile Number' : null,
//               ),
// Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: DropdownButtonFormField<String>(
//                   decoration: InputDecoration(
//                     labelText: 'Select Gender',
//                     border: OutlineInputBorder(),
//                   ),
//                   value: _details.selectedGender!.isNotEmpty
//                       ? _details.selectedGender
//                       : null,
//                   items: genders.map((gender) {
//                     return DropdownMenuItem(
//                       value: gender,
//                       child: Text(gender),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _details.selectedGender = value!;
//                     });
//                   },
//                   validator: (value) =>
//                       value == null ? 'Please select gender' : null,
//                 ),
//               ),
          
//                 Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     decoration: InputDecoration(labelText: '10th Percentage'),
//                     onSaved: (value) => _details.tenthPercentage = value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Enter 10th percentage' : null,
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 SizedBox(width: 16), // Space between fields
//                 Expanded(
//                   child: TextFormField(
//                     decoration: InputDecoration(labelText: '10th Year'),
//                     onSaved: (value) => _details.tenthYear = value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Enter 10th passing year' : null,
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//               ],
//             ),
//               Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     decoration: InputDecoration(labelText: '12th Percentage'),
//                     onSaved: (value) => _details.twelthPercentage = value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Enter 12th percentage' : null,
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 SizedBox(width: 16), // Space between fields
//                 Expanded(
//                   child: TextFormField(
//                     decoration: InputDecoration(labelText: '12th passing Year'),
//                     onSaved: (value) => _details.twelthYear = value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Enter 10th passing year' : null,
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//               ],
//             ),
//               Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     decoration: InputDecoration(labelText: 'Diploma percentage'),
//                     onSaved: (value) => _details.diplomaCgpa = value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Enter Diploma percentage' : null,
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 SizedBox(width: 16), // Space between fields
//                 Expanded(
//                   child: TextFormField(
//                     decoration: InputDecoration(labelText: 'Diploma passing Year'),
//                     onSaved: (value) => _details.diplomaYear= value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Enter Diploma passing year' : null,
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//               ],
//             ),
//              Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     decoration: InputDecoration(labelText: 'Graduation CGPA/SGPA'),
//                     onSaved: (value) => _details.graduationCgpa = value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Enter Graduation percentage' : null,
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 SizedBox(width: 16), // Space between fields
//                 Expanded(
//                   child: TextFormField(
//                     decoration: InputDecoration(labelText: 'Graduation passing Year'),
//                     onSaved: (value) => _details.graduationYear= value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Enter Graduation passing year' : null,
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//               ],
//             ),
//              Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     decoration: InputDecoration(labelText: 'PG CGPA/SGPA'),
//                     onSaved: (value) => _details.postGraduationCgpa = value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Enter Graduation percentage' : null,
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//                 SizedBox(width: 16), // Space between fields
//                 Expanded(
//                   child: TextFormField(
//                     decoration: InputDecoration(labelText: 'PG passing Year'),
//                     onSaved: (value) => _details.postGraduationYear= value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Enter PostGraduation passing year' : null,
//                     keyboardType: TextInputType.number,
//                   ),
//                 ),
//               ],
//             ),
//             TextFormField(
//                     decoration: InputDecoration(labelText: 'Your current postion'),
//                     onSaved: (value) => _details.currentPosition= value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Your current position Enter' : null,
//                     keyboardType: TextInputType.number,
//                   ),
                  
//               // Add fields for all other inputs following the same pattern
//               Row(
//                 children: [
//                   Text('Registration'),
//                   Switch(
//                     value: _details.registration,
//                     onChanged: (value) {
//                       setState(() {
//                         _details.registration = value;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Text('Passport'),
//                   Switch(
//                     value: _details.passport,
//                     onChanged: (value) {
//                       setState(() {
//                         _details.passport = value;
//                       });
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: _submitForm,
//                 child: Text('Submit'),
                
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
