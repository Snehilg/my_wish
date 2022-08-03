import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString tab = "Wishes".obs;

  changeTab(value) {
    tab.value = value;
  }
}
