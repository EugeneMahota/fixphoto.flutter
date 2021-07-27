import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tirmobile/assets/styles/theme.dart';
import 'package:tirmobile/shared/models/task.dart';
import 'package:intl/intl.dart';

class TasksList extends StatelessWidget {
  final List<Task> tasks;
  final Image logo = Image.asset('lib/assets/images/login-page-logo.png');

  TasksList({@required this.tasks});

  @override
  Expanded build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) =>
            _taskTile(tasks[index], index + 1),
      ),
    );
  }

  ListTile _taskTile(Task task, int index) {
    return ListTile(
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
      onTap: () => false,
    );
  }
}
