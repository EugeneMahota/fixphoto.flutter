import 'package:tirmobile/shared/helper/helper.dart';
import 'package:tirmobile/shared/models/login_response.dart';
import 'package:tirmobile/shared/models/task.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class WebApi {
  Future<LoginResponse> login(String login, String password);
  Future<List<Task>> getTasks();
}

class WebApiService implements WebApi {
  final _apiUrl = env['apiUrl'];
  final Map<String, String> _headers = {
    'Authorization': '',
    'Content-Type': 'application/json'
  };

  @override
  Future<LoginResponse> login(String login, String password) async {
    final uri = Uri.http(_apiUrl, '/mobileAuth');
    final result = await http.post(
      uri,
      body: jsonEncode({
        'login': login,
        'password': password,
      }),
      headers: _headers,
    );

    final parsed = jsonDecode(result.body);
    final LoginResponse loginResponse = LoginResponse.fromJson(parsed);
    _headers['Authorization'] = 'Bearer ${loginResponse.token}';
    return loginResponse;
  }

  @override
  Future<List<Task>> getTasks() async {
    final uri = Uri.http(_apiUrl, '/performer/tasks');
    print('headers');
    print(_headers);
    final result = await http.get(uri, headers: _headers);

    print(result.body);
    final parsedJson = parseJsonToObject(result.body);
    return parsedJson.map<Task>((json) => Task.fromJson(json)).toList();
  }
}
