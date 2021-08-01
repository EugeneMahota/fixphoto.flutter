import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tirmobile/assets/styles/theme.dart';
import 'package:tirmobile/shared/models/task.dart';
import 'package:tirmobile/shared/services/core/service_locator.dart';
import 'package:tirmobile/shared/widgets/text_with_loader.dart';
import 'package:tirmobile/task-module/task_view_model.dart';

class TaskScreen extends StatefulWidget {
  @override
  TaskScreenState createState() => TaskScreenState();
}

class TaskScreenState extends State {
  final TaskViewModel model = serviceLocator<TaskViewModel>();

  final TextEditingController _commentController =
      TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    _commentController.addListener(
      () => model.commentListener(_commentController),
    );
    model.initForm(_commentController);
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
        builder: (context, model, child) => _taskPage(model, task, context),
      ),
    );
  }

  Widget _taskPage(TaskViewModel model, Task task, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors().pink,
        title: Text('Отправить фотоотчет'),
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          _descriptionTask(task),
          _quantityPhotos(task),
          _timeTask(task),
          _images(),
          _commentField(task),
          _buttons(task, context),
        ],
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: EdgeInsets.all(15),
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

  Widget _quantityPhotos(Task task) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
      child: Text(
        'Добавлено фото: ${model.pickedImages.length} из ${task.photoCount}',
        style: TextStyle(
          fontSize: 15,
          color: AppColors().greySubtext,
        ),
      ),
    );
  }

  Widget _images() {
    final List<Widget> images = [];

    for (final image in model.pickedImages) {
      images.add(_imageBox(Image.file(image)));
    }

    return model.pickedImages.length > 0
        ? Container(
            margin: EdgeInsets.only(top: 15, bottom: 15),
            height: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: images,
            ),
          )
        : Container();
  }

  Widget _imageBox(Image image) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: SizedBox(
          height: 200,
          child: image,
        ),
      ),
    );
  }

  Widget _commentField(Task task) {
    return model.pickedImages.length == task.photoCount
        ? Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: CupertinoTextField(
              prefix: _fieldIcon(CupertinoIcons.bubble_right),
              keyboardType: TextInputType.text,
              padding: _paddingField(),
              placeholder: 'Комментарий',
              controller: _commentController,
            ),
          )
        : Container();
  }

  Widget _buttons(Task task, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, bottom: 15),
      child: Row(
        children: [
          model.pickedImages.length != task.photoCount
              ? MaterialButton(
                  child: Text(
                    model.pickedImages.length < 0
                        ? 'Сделать фото'
                        : 'Добавить фото',
                    style: TextStyle(
                      color: AppColors().white,
                    ),
                  ),
                  onPressed: () => model.takePhoto(),
                  color: AppColors().pink,
                )
              : MaterialButton(
                  child: TextWithLoader(
                    title: 'Отправить',
                    isLoading: model.isLoading,
                    color: AppColors().white,
                  ),
                  onPressed: () =>
                      model.sendPhotoAndCompleteTask(task.id, context),
                  color: AppColors().pink,
                ),
        ],
      ),
    );
  }

  EdgeInsets _paddingField() {
    return EdgeInsets.only(
      top: 15,
      bottom: 15,
      left: 15,
    );
  }

  Widget _fieldIcon(icon) {
    return Padding(
      padding: EdgeInsets.only(left: 15),
      child: Icon(icon),
    );
  }
}
