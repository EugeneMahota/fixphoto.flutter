import 'package:tirmobile/shared/models/task.dart';
import 'package:tirmobile/shared/services/api/web_api.dart';
import 'package:tirmobile/shared/services/core/service_locator.dart';

abstract class TasksServiceImpl {
  Future<List<Task>> getTasks();
}

class TasksService implements TasksServiceImpl {
  final WebApi _webApi = serviceLocator<WebApi>();
  List<Task> _tasks;

  @override
  Future<List<Task>> getTasks() async {
    if (_tasks != null) {
      return _tasks;
    }

    return _tasks = await _webApi.getTasks();
  }
}