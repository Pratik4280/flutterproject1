import 'package:flutter/material.dart';
import 'package:flygaulf/Maintestscreen.dart';
import 'package:google_fonts/google_fonts.dart';

class InstructionScreen extends StatelessWidget {
  const InstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.15, // Adjust height relative to screen
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
          SizedBox(height: screenHeight * 0.02), // Responsive spacing
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Exam Rules and Instructions:",
                style: GoogleFonts.lato(
                  fontSize: screenWidth * 0.05, // Responsive font size
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(screenWidth * 0.03),
              child: Container(
                margin: EdgeInsets.all(screenWidth * 0.02),
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Colors.blue,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                   boxShadow: [
      BoxShadow(
       // color: Colors.black.withOpacity(0.5), // Black shadow with transparency
       // offset: Offset(4, 4), // Horizontal and vertical offset
        blurRadius: 8, // Spread or blurriness of the shadow
       spreadRadius: 1, // How far the shadow extends
      ),
    ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._buildInstructionTexts(screenWidth),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.03),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(5, 7, 82, 1),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenHeight * 0.015,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
//                 Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) =>QuizScreen()),
// );

                // Handle navigation to the exam screen
              },
              child: Text(
                'Start Exam',
                style: TextStyle(fontSize: screenWidth * 0.045),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildInstructionTexts(double screenWidth) {
    return [
      RichText(
        text: TextSpan(
          style: GoogleFonts.lato(fontSize: screenWidth * 0.04, color: Colors.black),
          children: [
            TextSpan(
              text: '1. Question Format:\n',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(
              text: 'The exam consists of 30 Multiple-Choice Questions (MCQs).',
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      RichText(
        text: TextSpan(
          style: GoogleFonts.lato(fontSize: screenWidth * 0.04, color: Colors.black),
          children: [
            TextSpan(
              text: '2. Scoring:\n',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(
              text: 'Each question carries 1 mark.\nThere is no negative marking for incorrect answers.',
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      RichText(
        text: TextSpan(
          style: GoogleFonts.lato(fontSize: screenWidth * 0.04, color: Colors.black),
          children: [
            TextSpan(
              text: '3. Time Limit:\n',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(
              text: 'You have a total of 30 minutes to complete the exam.',
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      RichText(
        text: TextSpan(
          style: GoogleFonts.lato(fontSize: screenWidth * 0.04, color: Colors.black),
          children: [
            TextSpan(
              text: '4. Submission:\n',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(
              text:
                  'Ensure all questions are answered before submitting.\nThe exam will automatically submit when the timer ends.',
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      RichText(
        text: TextSpan(
          style: GoogleFonts.lato(fontSize: screenWidth * 0.04, color: Colors.black),
          children: [
            TextSpan(
              text: '5. Important Notes:\n',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(
              text:
                  'Do not refresh or close the Application during the exam.\nAny attempt to exit may result in submission of the test.',
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      RichText(
        text: TextSpan(
          style: GoogleFonts.lato(fontSize: screenWidth * 0.04, color: Colors.black),
          children: [
            const TextSpan(
              text: 'Click the ',
            ),
            const TextSpan(
              text: 'Start Exam',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const TextSpan(
              text: ' button below when you\'re ready. Best of luck!',
            ),
          ],
        ),
      ),
    ];
  }
}
