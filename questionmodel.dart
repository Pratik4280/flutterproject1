import 'dart:convert';
import 'package:http/http.dart' as http;

class Question {
  final int id;
  final String questionText;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String correctOption;

  Question({
    required this.id,
    required this.questionText,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.correctOption,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['question_id'],
      questionText: json['question_text'],
      optionA: json['option_a'],
      optionB: json['option_b'],
      optionC: json['option_c'],
      optionD: json['option_d'],
      correctOption: json['correct_option'],
    );
  }
}

Future<List<Question>> fetchQuestions() async {
  const String url = 'http://192.168.1.19/fgica/api_get_main_test.php';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print('API Response: $data'); // Log the API response
    if (data['questions'] == null) {
      throw Exception('Questions key is missing or null');
    }
    return (data['questions'] as List)
        .map((question) => Question.fromJson(question))
        .toList();
  } else {
    throw Exception('Failed to load questions');
  }
}
