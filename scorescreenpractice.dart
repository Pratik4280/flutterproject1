import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //   appBar: AppBar(
    //     centerTitle: true,
    //   title: Text("Main Test",style: TextStyle(color: Colors.white),),
    //   backgroundColor: Color.fromRGBO(5, 7, 82, 1), // Set the app bar color to blue
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       bottomLeft: Radius.circular(30),
    //       bottomRight: Radius.circular(30),
    //     ),
    //   ), // Apply bottom circular radius to app bar
    // ),
      body: Column(
       // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Container(
              width: double.infinity,
             // height: screenHeight * 0.15, // Adjust height relative to screen
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF050752).withOpacity(0.93),
                    const Color(0xFF0C0FB8).withOpacity(0.93),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: const Text(
                  'Main Test',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:53,left:20,right:20),
            child: Container(
              decoration: BoxDecoration(border: Border.all
              (color: Color.fromRGBO(5, 7, 82, 1),width: 2),
              borderRadius: BorderRadius.circular(20,)),
              height:310,
              child: Column(
               // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image in a responsive container
                Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), // Add circular border
                image: DecorationImage(
                  
                  image: AssetImage('assests/thumbs-up-7648171_1280 1.jpg',), // Corrected asset path
                  //fit: BoxFit.contain,
                ),
              ),
                 
                          ),
                          Container(
                          child:     Text(
                    "Congratulations! Your test has been submitted successfully.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(5, 7, 82, 1),
                    ),
                  ),
                          ),
                ]),
            ),
          ),
                      
              SizedBox(height: 16),
              // Additional message
              Text(
                "We’re currently processing your results, and they will be sent to your registered email address shortly.",
                textAlign: TextAlign.center,
               style: GoogleFonts.lato( // Use any Google Font you prefer
    fontSize: MediaQuery.of(context).size.width * 0.04,
    color: Colors.black87,
  ),
              ), 
              SizedBox(height: 45,),
                 Text(
                "Thank you for your participation!",
                textAlign: TextAlign.center,
               style: GoogleFonts.lato( // Use any Google Font you prefer
    fontSize: MediaQuery.of(context).size.width * 0.05,
    color: const Color.fromRGBO(0, 0, 0, 1),
  ),
              ),
              
          
        ],
      ),
    );
  }
}
  

  