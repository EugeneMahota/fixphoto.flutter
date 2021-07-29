import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tirmobile/shared/services/core/service_locator.dart';
import 'package:tirmobile/shared/services/image_picker_service.dart';
import 'package:tirmobile/shared/services/tasks_service.dart';
import 'dart:io';

class TaskViewModel extends ChangeNotifier {
  final TasksService _tasksService = serviceLocator<TasksService>();
  final ImagePickerService _imagePicker = serviceLocator<ImagePickerService>();

  File _pickedImage;
  File get pickedImage => _pickedImage;

  Future<void> takePhoto() async {
    final XFile image = await _imagePicker.takePhoto();
    if (image != null) {
      _pickedImage = File(image.path);
      notifyListeners();
    }
  }

  Future<void> sendPhotoAndCompleteTask(int taskId) async {
    await _tasksService.completeTask(taskId, pickedImage);
  }
}
