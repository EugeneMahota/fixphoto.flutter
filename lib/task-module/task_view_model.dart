import 'package:flutter/material.dart';
import 'package:tirmobile/shared/services/core/service_locator.dart';
import 'package:tirmobile/shared/services/tasks_service.dart';

class TaskViewModel extends ChangeNotifier {
  final TasksService _tasksService = serviceLocator<TasksService>();
}
