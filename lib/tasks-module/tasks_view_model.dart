import 'package:flutter/material.dart';
import 'package:tirmobile/shared/models/task.dart';
import 'package:tirmobile/shared/services/core/service_locator.dart';
import 'package:tirmobile/shared/services/tasks_service.dart';

class TasksViewModel extends ChangeNotifier {
  final TasksService _tasksService = serviceLocator<TasksService>();
  bool _isLoading = false;
  List<Task> _tasks = [];
  List<Task> _completedTasks = [];
  List<Task> _activeTasks = [];

  get tasks => _tasks;
  get completedTasks => _completedTasks;
  get activeTasks => _activeTasks;
  get isLoading => _isLoading;

  Future<void> loadData() async {
    _startLoading();
    await _getTasks();
    _finishLoading();
  }

  Future<void> reloadData() async {
    _startLoading();
    await _getTasks(true);
    _finishLoading();
  }

  void clearData() {
    _tasks = [];
  }

  Future<void> navigateToTask(Task task, BuildContext context) async {
    await Navigator.pushNamed(context, '/task', arguments: task)
        .then((value) => reloadData());
  }

  Future<void> _getTasks([bool isReload]) async {
    _tasks = await _tasksService.getTasks(isReload);

    _tasks.sort((a, b) => a.executionTime.compareTo(b.executionTime));

    _activeTasks = _tasks.where((task) => !task.completed).toList();
    _completedTasks = _tasks.where((task) => task.completed).toList();
  }

  _startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  _finishLoading() {
    _isLoading = false;
    notifyListeners();
  }
}
