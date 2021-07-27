import 'package:image_picker/image_picker.dart';

abstract class _ImagePickerService {
  Future<XFile> takePhoto();
}

class ImagePickerService implements _ImagePickerService {
  Future<XFile> takePhoto() async {
    return ImagePicker().pickImage(source: ImageSource.camera);
  }
}
