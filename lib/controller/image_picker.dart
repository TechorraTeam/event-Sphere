import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  var selectedImage = Rx<File?>(null); // Reactive variable to store image

  // Function to pick an image and store it in reactive variable
  static Future<void> pickImageFromGallery(
      Function(File?) onImagePicked) async {
    final ImagePicker _picker = ImagePicker();

    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    onImagePicked(pickedFile != null ? File(pickedFile.path) : null);
  }

  // Method to handle image selection and store it in reactive variable
  void pickImage() async {
    await pickImageFromGallery((File? pickedImage) {
      selectedImage.value = pickedImage; // Update reactive variable
    });
  }
}
