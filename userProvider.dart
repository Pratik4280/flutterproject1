import 'package:flutter/material.dart';
import 'package:flygaulf/Controller/usermodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> fetchUserDetails(String userId) async {
    final url = Uri.parse('http://192.168.1.19/fgica/api_user_details.php?user_id=$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final userData = data['data'][0]['user_details'];
      _user = User.fromJson(userData);
      notifyListeners();
    } else {
      throw Exception('Failed to load user details');
    }
  }
}
