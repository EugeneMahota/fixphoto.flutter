import 'package:image_picker/image_picker.dart';

abstract class _ImagePickerService {
  Future<XFile> takePhoto();
  Future<List<XFile>> takePhotos();
}

class ImagePickerService implements _ImagePickerService {
  Future<XFile> takePhoto() async {
    return ImagePicker().pickImage(source: ImageSource.camera);
  }

  Future<List<XFile>> takePhotos() async {
    return ImagePicker().pickMultiImage(imageQuality: 2);
  }
}
