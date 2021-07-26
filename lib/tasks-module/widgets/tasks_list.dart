import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tirmobile/shared/models/task.dart';

class TasksList extends StatelessWidget {
  final List<Task> tasks;

  TasksList({@required this.tasks});

  @override
  Expanded build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.all(10),
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) =>
            _taskTile(tasks[index]),
        separatorBuilder: (_, __) => Divider(),
      ),
    );
  }

  ListTile _taskTile(Task task) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(task.id.toString()),
      ),
      title: Text(task.description),
      subtitle: Text(task.id.toString()),
    );
  }
}
