import 'dart:io';

import 'package:tirmobile/shared/models/task.dart';
import 'package:tirmobile/shared/services/api/web_api.dart';
import 'package:tirmobile/shared/services/core/service_locator.dart';

abstract class TasksServiceImpl {
  Future<List<Task>> getTasks([bool isReload]);
  Future<void> completeTask(int taskId, File image);
}

class TasksService implements TasksServiceImpl {
  final WebApi _webApi = serviceLocator<WebApi>();
  List<Task> _tasks;

  @override
  Future<List<Task>> getTasks([bool isReload]) async {
    if (_tasks != null && isReload == false) {
      return _tasks;
    }

    return _tasks = await _webApi.getTasks();
  }

  @override
  Future<void> completeTask(int taskId, File image) {
    return _webApi.completeTask(taskId, image);
  }
}
