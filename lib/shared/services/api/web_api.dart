import 'package:tirmobile/shared/helper/helper.dart';
import 'package:tirmobile/shared/models/login_response.dart';
import 'package:tirmobile/shared/models/task.dart';
import 'package:tirmobile/shared/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class WebApi {
  Future<LoginResponse> login(String login, String password);
  Future<List<Task>> getTasks();
  Future<List<User>> getUsers();
}

class WebApiService implements WebApi {
  final _apiUrl = env['apiUrl'];
  final Map<String, String> _headers = {'Authorization': ''};

  @override
  Future<LoginResponse> login(String login, String password) async {
    // final uri = Uri.http(_apiUrl, '/mobileAuth');
    // final result = await http.post(
    //   uri,
    //   body: jsonEncode({
    //     'login': login,
    //     'password': password,
    //   }),
    //   headers: _headers,
    // );

    // final parsed = jsonDecode(result.body);
    // final LoginResponse loginResponse = LoginResponse.fromJson(parsed);
    // _headers['Authorization'] = loginResponse.token;
    // return loginResponse;
    return LoginResponse.fromJson({'token': 'Hi'});
  }

  @override
  Future<List<User>> getUsers() async {
    final uri = Uri.http(_apiUrl, '/posts');
    final result = await http.get(uri, headers: _headers);

    if (result.statusCode == 401) {
      print('getUser: status 401');
    }

    final parsedJson = parseJsonToObject(result.body);
    return parsedJson.map<User>((json) => User.fromJson(json)).toList();
  }

  @override
  Future<List<Task>> getTasks() async {
    // final uri = Uri.http(_apiUrl, '/performer/tasks');
    // final result = await http.get(uri, headers: _headers);

    // final parsedJson = parseJsonToObject(result.body);
    // return parsedJson.map<Task>((json) => Task.fromJson(json)).toList();
    return [];
  }
}
