import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tirmobile/assets/styles/theme.dart';
import 'package:tirmobile/shared/models/task.dart';
import 'package:tirmobile/shared/services/core/service_locator.dart';
import 'package:tirmobile/task-module/task_view_model.dart';

class TaskScreen extends StatefulWidget {
  @override
  TaskScreenState createState() => TaskScreenState();
}

class TaskScreenState extends State {
  final TaskViewModel model = serviceLocator<TaskViewModel>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Task task = ModalRoute.of(context).settings.arguments;

    return ChangeNotifierProvider<TaskViewModel>(
      create: (context) => model,
      child: Consumer<TaskViewModel>(
        builder: (context, model, child) => _taskPage(model, task),
      ),
    );
  }

  Widget _taskPage(TaskViewModel model, Task task) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().pink,
        title: Text('Отправить фотоотчет'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          Divider(),
          _descriptionTask(task),
          _timeTask(task),
          _takePhotoButton(task),
          model.pickedImage != null
              ? Center(
                  child: SizedBox(
                    height: 200,
                    child: Image.file(model.pickedImage),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Text(
        '#Описание задачи',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _descriptionTask(Task task) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
      child: Text(
        task.description,
        style: TextStyle(
          fontSize: 15,
          color: AppColors().greySubtext,
        ),
      ),
    );
  }

  Widget _timeTask(Task task) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
      child: Text(
        'Время окончания: ${DateFormat('HH:mm').format(task.executionTime)}',
        style: TextStyle(
          fontSize: 15,
          color: AppColors().greySubtext,
        ),
      ),
    );
  }

  Widget _takePhotoButton(Task task) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: MaterialButton(
        child: Text(
          'СДЕЛАТЬ ФОТО',
          style: TextStyle(
            color: AppColors().white,
          ),
        ),
        onPressed: () => model.takePhoto(),
        color: AppColors().pink,
      ),
    );
  }
}
