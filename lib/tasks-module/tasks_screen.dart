import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tirmobile/assets/styles/theme.dart';
import 'package:tirmobile/shared/services/core/service_locator.dart';
import 'package:tirmobile/shared/widgets/text_with_loader.dart';
import 'package:tirmobile/tasks-module/tasks_view_model.dart';
import 'package:tirmobile/tasks-module/widgets/tasks_list.dart';

class TasksScreen extends StatefulWidget {
  @override
  TasksScreenState createState() => TasksScreenState();
}

class TasksScreenState extends State {
  final TasksViewModel model = serviceLocator<TasksViewModel>();
  final String pageTitle = 'Список задач';

  @override
  void initState() {
    model.loadData();
    super.initState();
  }

  @override
  void dispose() {
    model.clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TasksViewModel>(
      create: (context) => model,
      child: Consumer<TasksViewModel>(
        builder: (context, model, child) => _tasksPage(model),
      ),
    );
  }

  Widget _tasksPage(TasksViewModel model) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors().pink,
          title: TextWithLoader(title: pageTitle, isLoading: model.isLoading),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => model.reloadData(),
            ),
          ],
        ),
        body: Column(
          children: [
            TasksList(
              model: model,
            ),
          ],
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
