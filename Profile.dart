// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   late Future<Map<String, dynamic>> userDetails;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool isEditing = false;

//   // Edit fields for the profile
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController genderController = TextEditingController();
//   TextEditingController positionController = TextEditingController();

//   // Fetch data from the API
//   Future<Map<String, dynamic>> fetchUserDetails() async {
//     final url = Uri.parse('http://192.168.1.19/fgica/api_user_details.php?user_id=27');
//     try {
//       final response = await http.get(url);
//       log('Raw Response: ${response.body}'); // Log the raw response

//       if (response.statusCode == 200) {
//         // Parse the JSON response
//         final Map<String, dynamic> jsonResponse = json.decode(response.body);
//         log('Parsed JSON: $jsonResponse'); // Log the parsed JSON

//         // Validate the structure
//         if (jsonResponse['status'] == 'success' && jsonResponse['data'] != null) {
//           final List<dynamic> dataList = jsonResponse['data'];

//           // Check if the dataList is not empty
//           if (dataList.isNotEmpty) {
//             final Map<String, dynamic> userDetails = dataList[0]['user_details'] ?? {};
//             final Map<String, dynamic> educationDetails = dataList[0]['education_details'] ?? {};

//             // Log parsed data for debugging
//             log('User Details: $userDetails');
//             log('Education Details: $educationDetails');

//             // Return a map containing user and education details
//             return {
//               'user_details': userDetails,
//               'education_details': educationDetails,
//             };
//           } else {
//             throw Exception('No data found in the response');
//           }
//         } else {
//           throw Exception('Invalid response structure: ${jsonResponse['status']}');
//         }
//       } else {
//         throw Exception('Failed to fetch data. HTTP Status: ${response.statusCode}');
//       }
//     } catch (e) {
//       log('Error fetching data: $e');
//       rethrow; // Propagate the error for the FutureBuilder to handle
//     }
//   }

//   // Function to send edited profile data to the server
//   Future<void> updateProfile(Map<String, String> userData) async {
//     final url = Uri.parse('http://192.168.1.19/fgica/api_edit_profile.php');

//     try {
//       final response = await http.post(
//         url,
//         body: userData,
//       );

//       if (response.statusCode == 200) {
//         // Handle success response from the server
//         log('Profile updated successfully');
//       } else {
//         // Handle failure response from the server
//         throw Exception('Failed to update profile. HTTP Status: ${response.statusCode}');
//       }
//     } catch (e) {
//       log('Error updating profile: $e');
//       throw Exception('Error updating profile: $e');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     userDetails = fetchUserDetails(); // Initialize userDetails
//   }

//   // Handle edit form submission
//   void saveProfile() {
//     if (_formKey.currentState?.validate() ?? false) {
//       setState(() {
//         isEditing = false;
//       });

//       // Prepare the user data to send to the server
//       final userData = {
//         'user_id': '27',  // You can dynamically set this based on the logged-in user
//         'name': nameController.text,
//         'email': emailController.text,
//         'mob': phoneController.text,
//       };

//       // Send the updated data to the server
//       updateProfile(userData).then((_) {
//         // You can display a success message or do something else after the update
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Profile updated successfully')),
//         );
//       }).catchError((e) {
//         // Handle any error in the update process
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error updating profile: $e')),
//         );
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Profile')),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: userDetails,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 'Error: ${snapshot.error}',
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(color: Colors.red),
//               ),
//             );
//           } else if (!snapshot.hasData || snapshot.data == null) {
//             return const Center(child: Text('No profile data available'));
//           }

//           final user = snapshot.data!['user_details'];
//           final education = snapshot.data!['education_details'];

//           return ListView(
//             padding: const EdgeInsets.all(16.0),
//             children: [
//               const CircleAvatar(
//                 radius: 50,
//                 child: Icon(Icons.person, size: 50),
//               ),
//               const SizedBox(height: 20),
//               if (isEditing) ...[
//                 // Show form with TextFormFields when editing
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       TextFormField(
//                         controller: nameController..text = user['user_name'] ?? '',
//                         decoration: const InputDecoration(labelText: 'Name'),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a name';
//                           }
//                           return null;
//                         },
//                       ),
//                       TextFormField(
//                         controller: emailController..text = user['user_email'] ?? '',
//                         decoration: const InputDecoration(labelText: 'Email'),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter an email';
//                           }
//                           return null;
//                         },
//                       ),
//                       TextFormField(
//                         controller: phoneController..text = user['user_mob'] ?? '',
//                         decoration: const InputDecoration(labelText: 'Mobile'),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter a mobile number';
//                           }
//                           return null;
//                         },
//                       ),
//                       TextFormField(
//                         controller: genderController..text = user['gender'] ?? '',
//                         decoration: const InputDecoration(labelText: 'Gender'),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter gender';
//                           }
//                           return null;
//                         },
//                       ),
//                       TextFormField(
//                         controller: positionController..text = user['position'] ?? '',
//                         decoration: const InputDecoration(labelText: 'Position'),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter position';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: saveProfile,
//                         child: const Text('Save Changes'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ] else ...[
//                 // Display data normally when not editing
//                 ListTile(
//                   leading: const Icon(Icons.person),
//                   title: const Text('Name'),
//                   subtitle: Text(user['user_name'] ?? 'Not Available'),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.edit),
//                     onPressed: () {
//                       setState(() {
//                         isEditing = true;
//                       });
//                     },
//                   ),
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.email),
//                   title: const Text('Email'),
//                   subtitle: Text(user['user_email'] ?? 'Not Available'),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.edit),
//                     onPressed: () {
//                       setState(() {
//                         isEditing = true;
//                       });
//                     },
//                   ),
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.phone),
//                   title: const Text('Mobile'),
//                   subtitle: Text(user['user_mob'] ?? 'Not Available'),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.edit),
//                     onPressed: () {
//                       setState(() {
//                         isEditing = true;
//                       });
//                     },
//                   ),
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.male),
//                   title: const Text('Gender'),
//                   subtitle: Text(user['gender'] ?? 'Not Available'),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.edit),
//                     onPressed: () {
//                       setState(() {
//                         isEditing = true;
//                       });
//                     },
//                   ),
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.work),
//                   title: const Text('Position'),
//                   subtitle: Text(user['position'] ?? 'Not Available'),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.edit),
//                     onPressed: () {
//                       setState(() {
//                         isEditing = true;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//               const Divider(),
//               // Education Details (Read-only)
//               ListTile(
//                 leading: const Icon(Icons.school),
//                 title: const Text('10th Percentage'),
//                 subtitle: Text(education['per_10th'] ?? 'Not Available'),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.calendar_today),
//                 title: const Text('10th Passing Year'),
//                 subtitle: Text(education['passing_year_10th']?.toString() ?? 'Not Available'),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.school),
//                 title: const Text('12th Percentage'),
//                 subtitle: Text(education['per_12th'] ?? 'Not Available'),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.calendar_today),
//                 title: const Text('12th Passing Year'),
//                 subtitle: Text(education['passing_year_12th']?.toString() ?? 'Not Available'),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.school),
//                 title: const Text('UG CGPA'),
//                 subtitle: Text(education['ug_cgpa'] ?? 'Not Available'),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.calendar_today),
//                 title: const Text('UG Passing Year'),
//                 subtitle: Text(education['passing_year_ug']?.toString() ?? 'Not Available'),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flygaulf/educationpro.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> userDetails;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isEditing = false;
   bool isEditing1 = false;

  // Edit fields for the profile
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  // Fetch data from the API
  Future<Map<String, dynamic>> fetchUserDetails() async {
    final url = Uri.parse('http://192.168.1.19/fgica/api_user_details.php?user_id=27');
    try {
      final response = await http.get(url);
      log('Raw Response: ${response.body}'); // Log the raw response

      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        log('Parsed JSON: $jsonResponse'); // Log the parsed JSON

        // Validate the structure
        if (jsonResponse['status'] == 'success' && jsonResponse['data'] != null) {
          final List<dynamic> dataList = jsonResponse['data'];

          // Check if the dataList is not empty
          if (dataList.isNotEmpty) {
            final Map<String, dynamic> userDetails = dataList[0]['user_details'] ?? {};
            final Map<String, dynamic> educationDetails = dataList[0]['education_details'] ?? {};

            // Log parsed data for debugging
            log('User Details: $userDetails');
            log('Education Details: $educationDetails');

            // Return a map containing user and education details
            return {
              'user_details': userDetails,
              'education_details': educationDetails,
            };
          } else {
            throw Exception('No data found in the response');
          }
        } else {
          throw Exception('Invalid response structure: ${jsonResponse['status']}');
        }
      } else {
        throw Exception('Failed to fetch data. HTTP Status: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching data: $e');
      rethrow; // Propagate the error for the FutureBuilder to handle
    }
  }

  // Function to send edited profile data to the server
  Future<void> updateProfile(Map<String, String> userData) async {
    final url = Uri.parse('http://192.168.1.19/fgica/api_edit_profile.php');

    try {
      final response = await http.post(
        url,
        body: userData,
      );

      if (response.statusCode == 200) {
        // Handle success response from the server
        log('Profile updated successfully');
        log(response.body);
      } else {
        // Handle failure response from the server
        throw Exception('Failed to update profile. HTTP Status: ${response.statusCode}');
      }
    } catch (e) {
      log('Error updating profile: $e');
      throw Exception('Error updating profile: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    userDetails = fetchUserDetails(); // Initialize userDetails
  }

  // Handle edit form submission
  void saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isEditing = false;
      });

      // Prepare the user data to send to the server
      final userData = {
        'user_id': '27',  // You can dynamically set this based on the logged-in user
        'name': nameController.text,
        'email': emailController.text,
        'mob': phoneController.text,
        'gender':genderController.text,
        'position': positionController.text
      };

      // Send the updated data to the server
      updateProfile(userData).then((_) {
        // You can display a success message or do something else after the update
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      }).catchError((e) {
        // Handle any error in the update process
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      });
    }
  }


  @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchUserDetails(), // Replace with your API call
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No profile data available'));
          }

          final user = snapshot.data!['user_details'];
          final education = snapshot.data!['education_details'];

          return Stack(
            children: [
              // Background with Curved Shape
              ClipPath(
                clipper: TopCurveClipper(),
                child: Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.blueAccent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 80),
                  // Profile Picture
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'http://192.168.1.19/fgica/' + (user['profile_photo'] ?? ''),
                      ),
                      child: user['profile_photo'] == null || user['profile_photo'].isEmpty
                          ? const Icon(Icons.person, size: 50)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Profile and Education Sections
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Stay on Profile Page
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "Profile",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                         Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => EducationDetailsPage(
        
      )), );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "Education",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: isEditing
                          ?  Form(
                            key: _formKey,
                            child: ListView(
                              children: [
                                TextFormField(
                                  controller: nameController..text = user['user_name'] ?? '',
                                  decoration: const InputDecoration(labelText: 'Name'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a name';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: emailController..text = user['user_email'] ?? '',
                                  decoration: const InputDecoration(labelText: 'Email'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter an email';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: phoneController..text = user['user_mob'] ?? '',
                                  decoration: const InputDecoration(labelText: 'Mobile'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a mobile number';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: genderController..text = user['gender'] ?? '',
                                  decoration: const InputDecoration(labelText: 'Gender'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter gender';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: positionController..text = user['position'] ?? '',
                                  decoration: const InputDecoration(labelText: 'Position'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter position';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: saveProfile,
                                  child: const Text('Save Changes'),
                                ),
                              ],
                            ),
                          )
                          : ListView(
  children: [
    // Profile Section
    Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.person, color: Colors.blue),
            title: Text(
              'Name',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.21,
                textBaseline: TextBaseline.alphabetic,
              ),
            ),
            subtitle: Text(
              user['user_name'] ?? 'Not Available',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                setState(() {
                  isEditing = true;
                });
              },
            ),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.email, color: Colors.blue),
            title: Text(
              'Email',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.21,
              ),
            ),
            subtitle: Text(
              user['user_email'] ?? 'Not Available',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                setState(() {
                  isEditing = true;
                });
              },
            ),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.phone, color: Colors.blue),
            title: Text(
              'Mobile',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.21,
              ),
            ),
            subtitle: Text(
              user['user_mob'] ?? 'Not Available',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                setState(() {
                  isEditing = true;
                });
              },
            ),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.male, color: Colors.blue),
            title: Text(
              'Gender',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.21,
              ),
            ),
            subtitle: Text(
              user['gender'] ?? 'Not Available',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                setState(() {
                  isEditing = true;
                });
              },
            ),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.work, color: Colors.blue),
            title: Text(
              'Position',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.21,
              ),
            ),
            subtitle: Text(
              user['position'] ?? 'Not Available',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                setState(() {
                  isEditing = true;
                });
              },
            ),
          ),

          Center(
            child:ElevatedButton(
  onPressed: () {
    setState(() {
      isEditing = true;
    });
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromRGBO(5, 7, 82, 1), // rgba(5, 7, 82, 1)
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8), // Optional: For rounded corners
    ),
  ),
  child: const Text(
    "Edit Profile",
    style: TextStyle(color: Colors.white), // Optional: Text color
  ),
),

          )
        ],
      ),
    ),
  ],
)

                  ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }

 
}

class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 100,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class EducationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Education")),
      body: const Center(child: Text("Education Details")),
    );
  }
}

   




