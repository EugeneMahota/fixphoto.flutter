import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tirmobile/assets/styles/theme.dart';
import 'package:tirmobile/shared/services/core/service_locator.dart';
import 'package:tirmobile/shared/services/image_picker_service.dart';
import 'package:tirmobile/shared/services/tasks_service.dart';
import 'dart:io';

class TaskViewModel extends ChangeNotifier {
  final TasksService _tasksService = serviceLocator<TasksService>();
  final ImagePickerService _imagePicker = serviceLocator<ImagePickerService>();

  String _comment;
  File _pickedImage;
  List<File> _pickedImages = [];
  bool isLoading = false;

  String get comment => _comment;
  File get pickedImage => _pickedImage;
  List<File> get pickedImages => _pickedImages;

  Future<void> takePhoto() async {
    final XFile image = await _imagePicker.takePhoto();
    if (image != null) {
      _pickedImages.add(File(image.path));
      notifyListeners();
    }
  }

  Future<void> sendPhotoAndCompleteTask(
      int taskId, BuildContext context) async {
    _startLoading();
    try {
      await _tasksService.completeTask(taskId, pickedImages, comment);
      Navigator.pushNamed(context, '/tasks');
    } catch (err) {
      _showErrorMessage(context);
    }
    _finishLoading();
  }

  _showErrorMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors().backgroundRedError,
        content: Text('Ошибка загруки изображения!'),
      ),
    );
  }

  void initForm(TextEditingController commentController) {
    _comment = commentController.text;
  }

  void commentListener(TextEditingController commentController) {
    _comment = commentController.text;
  }

  void _startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void _finishLoading() {
    isLoading = false;
    notifyListeners();
  }
}
