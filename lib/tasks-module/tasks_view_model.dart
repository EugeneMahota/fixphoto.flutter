import 'package:flutter/material.dart';
import 'package:tirmobile/shared/models/task.dart';
import 'package:tirmobile/shared/services/core/service_locator.dart';
import 'package:tirmobile/shared/services/tasks_service.dart';

class TasksViewModel extends ChangeNotifier {
  final TasksService _tasksService = serviceLocator<TasksService>();
  List<Task> _tasks = [];

  get tasks => _tasks;

  Future<void> loadData() async {
    await _getTasks();
    notifyListeners();
  }

  void clearData() {
    _tasks = [];
  }

  Future<void> _getTasks() async {
    _tasks = await _tasksService.getTasks();
  }
}
