// import 'package:flutter/material.dart';
// import 'package:flygaulf/Controller/formcontroller.dart';
// import 'package:provider/provider.dart';

// class EducationalFormPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final controller = Provider.of<FormController>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Educational Details Form'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           child: Column(
//             children: [
//               // Name Field
//               TextField(
//                 controller: controller.nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Name',
//                   errorText: controller.isNameValid ? null : 'Please enter a name',
//                 ),
//               ),
//               // Mobile Number Field
//               TextField(
//                 controller: controller.mobController,
//                 decoration: InputDecoration(
//                   labelText: 'Mobile Number',
//                   errorText: controller.isMobValid ? null : 'Enter a valid mobile number',
//                 ),
//                 keyboardType: TextInputType.phone,
//               ),
//               // Email Field
//               TextField(
//                 controller: controller.emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   errorText: controller.isEmailValid ? null : 'Enter a valid email address',
//                 ),
//                 keyboardType: TextInputType.emailAddress,
//               ),
//               // Gender Selection
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text('Gender:'),
//                   Radio<String>(
//                     value: 'Male',
//                     groupValue: controller.gender,
//                     onChanged: (value) {
//                       controller.gender = value!;
//                       controller.notifyListeners();
//                     },
//                   ),
//                   Text('Male'),
//                   Radio<String>(
//                     value: 'Female',
//                     groupValue: controller.gender,
//                     onChanged: (value) {
//                       controller.gender = value!;
//                       controller.notifyListeners();
//                     },
//                   ),
//                   Text('Female'),
//                 ],
//               ),
//               // 10th Percentage Field
//               TextField(
//                 controller: controller.per10thController,
//                 decoration: InputDecoration(labelText: '10th Percentage'),
//               ),
//               // 12th Percentage Field
//               TextField(
//                 controller: controller.per12thController,
//                 decoration: InputDecoration(labelText: '12th Percentage'),
//               ),
//               // Diploma Percentage Field
//               TextField(
//                 controller: controller.diplomaPerController,
//                 decoration: InputDecoration(labelText: 'Diploma Percentage'),
//               ),
//               // UG CGPA Field
//               TextField(
//                 controller: controller.ugCgpaController,
//                 decoration: InputDecoration(labelText: 'UG CGPA'),
//               ),
//               // PG CGPA Field
//               TextField(
//                 controller: controller.pgCgpaController,
//                 decoration: InputDecoration(labelText: 'PG CGPA'),
//               ),
//               // Registration and Passport Fields
//               Row(
//                 children: [
//                   Text('Registration:'),
//                   Switch(
//                     value: controller.registration,
//                     onChanged: (value) {
//                       controller.registration = value;
//                       controller.notifyListeners();
//                     },
//                   ),
//                   Text('Passport:'),
//                   Switch(
//                     value: controller.passport,
//                     onChanged: (value) {
//                       controller.passport = value;
//                       controller.notifyListeners();
//                     },
//                   ),
//                 ],
//               ),
//               // Position Field
//               TextField(
//                 controller: controller.positionController,
//                 decoration: InputDecoration(labelText: 'Current Position'),
//               ),
//               // Submit Button
//               ElevatedButton(
//                 onPressed: () {
//                   controller.submitForm(context);
//                 },
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flygaulf/Controller/provideredu.dart';

import 'package:flygaulf/Model/colorcode.dart';
import 'package:flygaulf/Model/educationmodel.dart';
import 'package:flygaulf/Model/font.dart';
import 'package:flygaulf/Model/screensize.dart';


import 'package:provider/provider.dart';


class EducationFormScreen extends StatefulWidget {
  final String email;
  // User user;
  const EducationFormScreen({super.key, required this.email, });

  @override
  State createState() => _EducationFormScreenState();
}

class _EducationFormScreenState extends State<EducationFormScreen> {
  final _formKey = GlobalKey<FormState>();  
  final _details = EducationDetails(
    name: '',
    email: '',
    mobile: '',
    tenthPercentage: '',
    tenthYear: '',
    twelthPercentage: '',
    twelthYear: '',
    diplomaCgpa: '',
    diplomaYear: '',
    graduationCgpa: '',
    graduationYear: '',
    postGraduationCgpa: '',
    postGraduationYear: '',
    currentPosition: '',
    selectedGender: '',
    registration: false,
    passport: false,
  );

  final List<String> genders = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    _details.email=widget.email;
    print(_details.email);
  }

  void _submitForm() async {
    print(_formKey.currentState!.validate());
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      try {
        final emailProvider=Provider.of<EducationProvider>(context, listen: false);
        await emailProvider.submitForm(_details);
        if(await emailProvider.login){
          print(emailProvider.login);
          print(emailProvider.user);
          print(emailProvider.user.name);
          print(emailProvider.user.id);
          print(emailProvider.user.email);
          
        log("successfully login");
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit form')),
        );
      }
    }
      
    
  }

  @override
  Widget build(BuildContext context) {
    final screenSize=ScreenSizeHelper(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top:screenSize.scaleHeight(31),
            left: screenSize.scaleWidth(38),
            right: screenSize.scaleWidth(38)
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               buildInputField(
                  labelText: "Enter Your Name:",
                   validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Name can not be empty';
          }
          if (value.contains('1')||
          value.contains('2')||
          value.contains('3')||
          value.contains('4')||
          value.contains('5') ||value.contains('6')||
          value.contains('7')||value.contains('8')||
          value.contains('9')||value.contains('0')) {
            return ' only charater allowed';
          }
          return null; // Valid name
        },
        onSaved: (value) {
          if (value != null) {
            _details.name = value;
          }
        },
                 screenSize: screenSize
                ), 

//onSaved:(value) => _details.name = value!,
                
                Padding(
                  padding: EdgeInsets.only(top:screenSize.scaleHeight(10)),
                  child: buildInputField(
                    labelText: "Enter Your Mobile No :",
                     validator: (value) {
            if (value?.length != 10) {
      return 'Number must be exactly 10 digits';
    }
          return null; // Valid name
        },
                    onSaved: (value) =>  (value) => _details.mobile = value!,
                    screenSize: screenSize,
                  ),
                
                ),
               
                Padding(
                  padding: EdgeInsets.only(top:screenSize.scaleHeight(10)),
                  child: Column(
                    children: [ 
                      Padding(
                         padding: EdgeInsets.only(top:screenSize.scaleHeight(10),right: 160),
                         child: Text("Enter Your Postion",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),),

                    TextFormField(
  decoration: InputDecoration(
    hintText: "Eg: Doctor", 
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0), // Adjust the radius for rounded corners
    ),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }
    // Check if the value contains any digits
    if (value.contains(RegExp(r'[0-9]'))) {
      return 'Only characters allowed';
    }
    return null; // Valid input
  },
  onSaved: (value) => _details.currentPosition = value!,
),

                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:screenSize.scaleHeight(10)),
                  child: Text(
                    "10th Percentage and Passing Year :",
                    style: FontHelper.lato(
                      fontSize: screenSize.scaleFont(16),
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:screenSize.scaleHeight(10)),
                  child: Row(
                    children: [
                      CustomTextField(
                        width: screenSize.scaleWidth(140), 
                        height: screenSize.scaleHeight(44), 
                        borderRadius: screenSize.scaleWidth(5), 
                        hintText: 'Percentage',
                        borderColor: const Color.fromRGBO(0,0,0,0.3), 
                        onSaved: (value){
                          _details.tenthPercentage  = value!;
                        },
                         validator: (value) {
          if (value == null || value.isEmpty) {
            return 'enter valid percentage';
          }
          if (value.contains('a')||
          value.contains('b')||
          value.contains('c')||
          value.contains('c')||
          value.contains('d') ||value.contains('e')||
          value.contains('f')||value.contains('g')||
          value.contains('h')||value.contains('i')) {
            return 'Enter valid number';
          }
          return null; // Valid name
        },
                        keyboardType: TextInputType.number,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:screenSize.scaleHeight(20)),
                        child: CustomTextField(
                          width: screenSize.scaleWidth(143), 
                          height: screenSize.scaleHeight(44), 
                          hintText: 'Passing Year',
                          borderRadius: screenSize.scaleWidth(5), 
                          borderColor: const Color.fromRGBO(0,0,0,0.3), 
                          onSaved: (value){
                            _details.tenthYear = value!;
                          },
                          validator: (value) =>
                              value!.isEmpty ? 'Enter 10th passing year' : null,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:screenSize.scaleHeight(10)),
                  child: Text(
                    "12th Percentage and Passing Year :",
                    style: FontHelper.lato(
                      fontSize: screenSize.scaleFont(16),
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:screenSize.scaleHeight(10)),
                  child: Row(
                    children: [
                      CustomTextField(
                        width: screenSize.scaleWidth(140), 
                        height: screenSize.scaleHeight(44), 
                        borderRadius: screenSize.scaleWidth(5), 
                        hintText: 'Percentage',
                        borderColor: const Color.fromRGBO(0,0,0,0.3), 
                        onSaved: (value) => _details.twelthPercentage = value!,
                      validator: (value) {
          if (value == null || value.isEmpty) {
            return 'enter valid percentage';
          }
          if (value.contains('a')||
          value.contains('b')||
          value.contains('c')||
          value.contains('d')||
          value.contains('e') ||value.contains('6')||
          value.contains('f')||value.contains('g')||
          value.contains('h')||value.contains('i')||
          value.contains('j')||value.contains('k')||value.contains('l')||value.contains('m')||value.contains('n')) {
            return 'Enter valid percentage';
          }
          return null; // Valid name
                      },
                        keyboardType: TextInputType.number,
                    
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:screenSize.scaleHeight(20)),
                        child: CustomTextField(
                          width: screenSize.scaleWidth(143), 
                          height: screenSize.scaleHeight(44), 
                          hintText: 'Passing Year',
                          borderRadius: screenSize.scaleWidth(5), 
                          borderColor: const Color.fromRGBO(0,0,0,0.3), 
                          onSaved: (value) => _details.twelthYear = value!,
                          validator:(value) =>
                            value!.isEmpty ? 'Enter 12th passing year' : null,
                        keyboardType: TextInputType.number,
                        ),
                      ),
                      
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:screenSize.scaleHeight(10)),
                  child: Text(
                    "Diploma CGPA and Passing Year :",
                    style: FontHelper.lato(
                      fontSize: screenSize.scaleFont(16),
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:screenSize.scaleHeight(10)),
                  child: Row(
                    children: [
                      CustomTextField(
                        width: screenSize.scaleWidth(140), 
                        height: screenSize.scaleHeight(44), 
                        hintText: 'Percentage',
                        borderRadius: screenSize.scaleWidth(5), 
                        borderColor: const Color.fromRGBO(0,0,0,0.3), 
                        onSaved: (value) {
                            _details.diplomaCgpa = (value?.isNotEmpty == true ? value : '-')!;
                          },
                     validator: (value) {
          if (value == null || value.isEmpty) {
            return 'enter valid cgpa';
          }
          if (value.contains('a')||
          value.contains('b')||
          value.contains('c')||
          value.contains('d')||
          value.contains('e') ||value.contains('6')||
          value.contains('f')||value.contains('g')||
          value.contains('h')||value.contains('i')||
          value.contains('j')||value.contains('k')||value.contains('l')||value.contains('m')||value.contains('n')) {
            return  'enter valid cgpa';
          }
          return null; // Valid name
                      },
                        keyboardType: TextInputType.number,
                    
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:screenSize.scaleHeight(20)),
                        child: CustomTextField(
                          width: screenSize.scaleWidth(143), 
                          height: screenSize.scaleHeight(44), 
                          hintText: 'Passing Year',
                          borderRadius: screenSize.scaleWidth(5), 
                          borderColor: const Color.fromRGBO(0,0,0,0.3), 
                          onSaved: (value) {
                            _details.diplomaYear = (value?.isNotEmpty == true ? value : '-')!;
                          },
                          validator:(value) =>
                            value!.isEmpty ? 'Enter Diploma passing year' : null,
                        keyboardType: TextInputType.number,
                        ),
                      ),
                      
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:screenSize.scaleHeight(10)),
                  child: Text(
                    "Graduation CGPA and Passing Year :",
                    style: FontHelper.lato(
                      fontSize: screenSize.scaleFont(16),
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:screenSize.scaleHeight(10)),
                  child: Row(
                    children: [
                      CustomTextField(
                        
                        
                        width: screenSize.scaleWidth(140), 
                        height: screenSize.scaleHeight(44), 
                        borderRadius: screenSize.scaleWidth(5), 
                        hintText:'CGPA',
                        borderColor: const Color.fromRGBO(0,0,0,0.3), 
                        onSaved:  (value) => _details.graduationCgpa = value!,
                     validator: (value) {
          if (value == null || value.isEmpty) {
            return  'enter valid cgpa';
          }
          if (value.contains('a')||
          value.contains('b')||
          value.contains('c')||
          value.contains('d')||
          value.contains('e') ||value.contains('6')||
          value.contains('f')||value.contains('g')||
          value.contains('h')||value.contains('i')||
          value.contains('j')||value.contains('k')||value.contains('l')||value.contains('m')||value.contains('n')) {
            return  'enter valid cgpa';
          }
          return null; // Valid name
                      },
                        keyboardType: TextInputType.number,
                    
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:screenSize.scaleHeight(20)),
                        child: CustomTextField(
                          width: screenSize.scaleWidth(143), 
                          height: screenSize.scaleHeight(44), 
                          hintText: 'Passing Year',
                          borderRadius: screenSize.scaleWidth(5), 
                          borderColor: const Color.fromRGBO(0,0,0,0.3), 
                          onSaved: (value) => _details.graduationYear= value!,
                          validator:(value) =>
                            value!.isEmpty ? 'Enter Graduation passing year' : null,
                        keyboardType: TextInputType.number,
                        ),
                      ),
                      
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:screenSize.scaleHeight(10)),
                  child: Text(
                    "Post Graduation CGPA and Passing Year :",
                    style: FontHelper.lato(
                      fontSize: screenSize.scaleFont(16),
                      fontWeight: FontWeight.w600,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top:screenSize.scaleHeight(10)),
                  child: Row(
                    children: [
                      CustomTextField(
                        width: screenSize.scaleWidth(140), 
                        height: screenSize.scaleHeight(44),
                        hintText: 'Post Graduation Percentage', 
                        borderRadius: screenSize.scaleWidth(5), 
                        borderColor: const Color.fromRGBO(0,0,0,0.3), 
                        onSaved:  (value) => _details.postGraduationCgpa = value!,
                     validator: (value) {
          if (value == null || value.isEmpty) {
            return  'enter valid cgpa';
          }
          if (value.contains('a')||
          value.contains('b')||
          value.contains('c')||
          value.contains('d')||
          value.contains('e') ||value.contains('6')||
          value.contains('f')||value.contains('g')||
          value.contains('h')||value.contains('i')||
          value.contains('j')||value.contains('k')||value.contains('l')||value.contains('m')||value.contains('n')) {
            return  'enter valid cgpa';
          }
          return null; // Valid name
                      },
                        keyboardType: TextInputType.number,
                    
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:screenSize.scaleHeight(20)),
                        child: CustomTextField(
                          width: screenSize.scaleWidth(143), 
                          height: screenSize.scaleHeight(44), 
                          hintText: 'Post Graduation Passing year', 
                          borderRadius: screenSize.scaleWidth(5), 
                          borderColor: const Color.fromRGBO(0,0,0,0.3), 
                          onSaved: (value) => _details.postGraduationYear= value!,
                          validator: (value) =>
                            value!.isEmpty ? 'Enter PostGraduation Passing year' : null,
                        keyboardType: TextInputType.number,
                        ),
                      ),
                      
                    ],
                  ),
                ),
                Text(
                  "Select Gender :",
                  style: FontHelper.lato(
                    fontSize: screenSize.scaleFont(16),
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                      top:screenSize.scaleHeight(10)
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        //labelText: 'Select Gender',
                        border: OutlineInputBorder(),
                      ),
                      value: _details.selectedGender!.isNotEmpty
                          ? _details.selectedGender
                          : null,
                      items: genders.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _details.selectedGender = value!;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Please select gender' : null,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.scaleHeight(10)
                    ),
                    child: Text(
                      "Registration :",
                      style: FontHelper.lato(
                        fontSize: screenSize.scaleFont(16),
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.scaleHeight(10)
                    ),
                    child:Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            title: Text("Yes",
                              style: FontHelper.lato(
                                fontSize: screenSize.scaleFont(16),
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(0, 0, 0, 1)
                              ),
                            ),
                            activeColor: AppColor.btnColor,
                            value: _details.registration,
                            onChanged: (value) {
                              setState(() {
                                _details.registration = true; // Set to true for "Yes"
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            title: Text("No",
                              style: FontHelper.lato(
                                fontSize: screenSize.scaleFont(16),
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(0, 0, 0, 1)
                              ),
                            ),
                            activeColor: AppColor.btnColor,
                            value: !_details.registration,
                            onChanged: (value) {
                              setState(() {
                                _details.registration = false; // Set to false for "No"
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                      ],
                    )
                  
                  ),
                Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.scaleHeight(10)
                    ),
                    child: Text(
                      "Passport :",
                      style: FontHelper.lato(
                        fontSize: screenSize.scaleFont(16),
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenSize.scaleHeight(7)
                    ),
                    child:Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            title: Text("Yes",
                              style: FontHelper.lato(
                                fontSize: screenSize.scaleFont(16),
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(0, 0, 0, 1)
                              ),
                            ),
                            activeColor: AppColor.btnColor,
                            value: _details.passport,
                            onChanged: (value) {
                              setState(() {
                                _details.passport = true; // Set to true for "Yes"
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            title: Text("No",
                              style: FontHelper.lato(
                                fontSize: screenSize.scaleFont(16),
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(0, 0, 0, 1)
                              ),
            
                            ),
                            activeColor: AppColor.btnColor,
                            value: !_details.passport,
                            onChanged: (value) {
                              setState(() {
                                _details.passport = false; // Set to false for "No"
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                          ),
                        ),
                      ],
                    )
                  
                  ),
            
                  Padding(
                    padding:  EdgeInsets.only(
                      top:screenSize.scaleHeight(29)
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: (){
                          print("On Tap");
                          _submitForm();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: screenSize.scaleHeight(45),
                          width: screenSize.scaleWidth(113),
                          decoration: BoxDecoration(
                            color: AppColor.btnColor,
                            borderRadius: BorderRadius.circular(screenSize.scaleWidth(8))
                          ),
                          child: Text(
                            "SUBMIT",
                            style: FontHelper.lato(
                              fontSize: screenSize.scaleFont(24),
                              fontWeight: FontWeight.w700,
                              color: AppColor.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                    
              ],
            ),
          ),
        ),
      ),
    );
  }

   Widget buildInputField({
  required String labelText,
  required String? Function(String?) validator,
  required void Function(String?) onSaved,
  required ScreenSizeHelper screenSize,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        labelText,
        style: FontHelper.lato(
          fontSize: screenSize.scaleFont(16),
          fontWeight: FontWeight.w600,
          color: const Color.fromRGBO(0, 0, 0, 1),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: screenSize.scaleHeight(10),
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenSize.scaleWidth(5)),
              borderSide: const BorderSide(
                color: Color.fromRGBO(0, 0, 0, 0.3),
              ),
            ),
          ),
          onSaved: onSaved,
          validator: validator,
        ),
      ),
    ],
  ); 

}
}


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const CustomAppBar({super.key})
      : preferredSize = const Size.fromHeight(91);

  @override
  Widget build(BuildContext context) {
    final screenSize = ScreenSizeHelper(context);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(5, 7, 82, 0.93),
            Color.fromRGBO(12, 15, 184, 0.93),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20), // Adjust as needed
          bottomRight: Radius.circular(20), // Adjust as needed
        ),
      ),
      child: AppBar(
        elevation: 0, // Remove the default elevation shadow
        backgroundColor: Colors.transparent, // Make AppBar background transparent
         title: Text(
          'Details',
          style: FontHelper.lato(
            fontSize: screenSize.scaleFont(22), // You can customize the font size as needed
            fontWeight: FontWeight.w600,
            color: AppColor.white
          ),
        ),
        centerTitle: true, // Center the title
        
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color borderColor;
  final void Function(String?) onSaved;
  final String? Function(String?) validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;

  const CustomTextField({
    Key? key,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.borderColor,
    required this.onSaved,
    required this.validator,
    this.controller,
    this.keyboardType,
    this.hintText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor),
          ),
        ),
      //  onSaved: onSaved,
        validator: validator,
      ),
    );
  }
}

