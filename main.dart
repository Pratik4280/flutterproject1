// // import 'package:flutter/material.dart';
// // import 'package:flygaulf/educationform.dart';

// // void main() {
// //   runApp(const MainApp());
// // }

// // class MainApp extends StatelessWidget {
// //   const MainApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return const MaterialApp(
// //       home: EducationDetailsScreen()
// //       );
    
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flygaulf/Controller/provideredu.dart';
// import 'package:flygaulf/Profile.dart';
// import 'package:flygaulf/educationform.dart';
// import 'package:provider/provider.dart';


// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//       ChangeNotifierProvider(create: (_) => EducationProvider(),),
//        // ChangeNotifierProvider(create: (_) => ProfileProvider(),),

//       ],
//       child: MaterialApp(
//         home: EducationFormScreen(),
//       ),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:flygaulf/Controller/formcontroller.dart';
import 'package:flygaulf/Maintestscreen.dart';
import 'package:flygaulf/Profile.dart';
import 'package:flygaulf/educationpro.dart';
import 'package:flygaulf/formui.dart';

import 'package:flygaulf/rulesmaintest.dart';
import 'package:flygaulf/scorescreenpractice.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return ChangeNotifierProvider(
      
      create: (_) => FormController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Educational Form',
        initialRoute: '/',
        routes: {
          '/': (context) =>EducationalFormPage(),
         // '/maintest': (context) => QuizScreen(),
         // '/profile': (context) => ProfilePage(),
        },
      ),
    );
  }
}
