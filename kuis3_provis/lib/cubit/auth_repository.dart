import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepository {
  Future<http.Response> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://146.190.109.66:8000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    return response;
  }

  Future<http.Response> daftar(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://146.190.109.66:8000/users/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    return response;
  }
}
