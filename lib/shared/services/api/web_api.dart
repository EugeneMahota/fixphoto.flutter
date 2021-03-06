import 'package:tirmobile/shared/helper/helper.dart';
import 'package:tirmobile/shared/models/login_response.dart';
import 'package:tirmobile/shared/models/task.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

abstract class WebApi {
  Future<LoginResponse> login(String login, String password);
  Future<List<Task>> getTasks();
  Future<void> completeTask(int taskId, List<File> images, String comment);
}

class WebApiService implements WebApi {
  final _apiUrl = env['apiUrl'];
  final Map<String, String> _headers = {
    'Authorization': '',
    'Content-Type': 'application/json',
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
    final result = await http.get(uri, headers: _headers);
    final body = utf8.decode(result.bodyBytes);

    final parsedJson = parseJsonToObject(body);
    return parsedJson.map<Task>((json) => Task.fromJson(json)).toList();
  }

  @override
  Future<void> completeTask(
      int taskId, List<File> images, String comment) async {
    final Dio dio = new Dio(
      BaseOptions(headers: {'Authorization': _headers['Authorization']}),
    );
    final url = 'http://$_apiUrl/tasks/completed/$taskId';

    final List<MultipartFile> files = [];
    for (final image in images) {
      final file = await MultipartFile.fromFile(image.path, filename: 'image');
      files.add(file);
    }

    final formData = FormData.fromMap({
      'comment': comment,
      'images': files,
    });
    return await dio.post(url, data: formData);
  }
}
