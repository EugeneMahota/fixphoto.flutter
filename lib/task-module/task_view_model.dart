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

  File _pickedImage;
  bool isLoading = false;

  File get pickedImage => _pickedImage;

  Future<void> takePhoto() async {
    final XFile image = await _imagePicker.takePhoto();
    if (image != null) {
      _pickedImage = File(image.path);
      notifyListeners();
    }
  }

  Future<void> sendPhotoAndCompleteTask(
      int taskId, BuildContext context) async {
    _startLoading();
    try {
      await _tasksService.completeTask(taskId, pickedImage);
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

  void _startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void _finishLoading() {
    isLoading = false;
    notifyListeners();
  }
}
