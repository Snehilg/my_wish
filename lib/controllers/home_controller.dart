import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  RxString tab = "Wishes".obs;
  RxString selectedPicture = "".obs;
  ImagePicker imagePicker = ImagePicker();

  changeTab(value) {
    tab.value = value;
  }

  //image picking and path saving functionality
  selectPicture() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedPicture.value = pickedFile.path;
    }
  }
}
