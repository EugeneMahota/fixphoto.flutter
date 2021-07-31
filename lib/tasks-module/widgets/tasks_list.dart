import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tirmobile/assets/styles/theme.dart';
import 'package:tirmobile/shared/models/task.dart';
import 'package:intl/intl.dart';
import 'package:tirmobile/tasks-module/tasks_view_model.dart';

class TasksList extends StatelessWidget {
  final TasksViewModel model;
  final Image logo = Image.asset('lib/assets/images/login-page-logo.png');

  TasksList({@required this.model});

  @override
  Expanded build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          _activeTitle(model.activeTasks),
          ..._buildTiles(model.activeTasks, context),
          _copletedTitle(model.completedTasks),
          ..._buildTiles(model.completedTasks, context),
        ],
      ),
    );
  }

  _activeTitle(List<Task> tasks) {
    return tasks.length != 0 ? _title('В процессе') : Container();
  }

  _copletedTitle(List<Task> tasks) {
    return tasks.length != 0 ? _title('Выполненно') : Container();
  }

  Widget _title(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 15, top: 15, bottom: 5),
      child: Text(
        title,
        style: TextStyle(color: AppColors().greySubtext),
      ),
    );
  }

  List<ListTile> _buildTiles(List<Task> tasks, BuildContext context) {
    final List<ListTile> tiles = [];
    for (final task in tasks) {
      tiles.add(_taskTile(task, context));
    }

    return tiles;
  }

  ListTile _taskTile(Task task, BuildContext context) {
    return ListTile(
      enabled: !_isDisableTask(task),
      leading: CircleAvatar(
        backgroundColor: AppColors().pink,
        child: logo,
      ),
      title: Padding(
        child: Text(task.description),
        padding: EdgeInsets.only(top: 10),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Text(
            'Сделать до: ${DateFormat('dd.MM.yyyy HH:mm').format(task.executionTime)}'),
      ),
      onTap: () => model.navigateToTask(task, context),
    );
  }

  bool _isDisableTask(Task task) {
    if (task.completed) {
      return true;
    }

    final int nowTimeMilliseconds = DateTime.now().millisecondsSinceEpoch;
    final int executionTimeMilliseconds =
        task.executionTime.millisecondsSinceEpoch;
    final int twoHoursMilliseconds = 1000 * 60 * 60 * 2;

    final diffirentTimeExecutionAndNow =
        executionTimeMilliseconds - nowTimeMilliseconds;
    if (diffirentTimeExecutionAndNow > twoHoursMilliseconds) {
      return true;
    }

    return false;
  }
}
