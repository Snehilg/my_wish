import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Root(),
    );
  }
}

//root to show screen according to
// user is  logged in or not
class Root extends StatelessWidget {
  //attaching controller once to be used and found by others too
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    //as soon as user logins home screen will open
    return Obx(
      () => authController.user.value != null ? HomeScreen() : AuthScreen(),
    );
  }
}
