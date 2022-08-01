import 'package:flutter/material.dart';
import 'package:my_wish/utils.dart';
import 'package:get/get.dart';
import 'package:my_wish/controllers/auth_controller.dart';

class AuthScreen extends StatelessWidget {
  AuthController authController = Get.put(AuthController());

  buildTab(text, selected, context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 40,
      child: Center(
        child: Text(
          text,
          style: selected
              ? textStyle(22, Colors.lightBlueAccent, FontWeight.bold)
              : textStyle(22, Colors.grey, FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Wishes",
                style: textStyle(35, Colors.lightBlue, FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => Row(
                  children: [
                    InkWell(
                      onTap: () => authController.changeTab("Login"),
                      child: buildTab("Login",
                          authController.tab.value == "Login", context),
                    ),
                    InkWell(
                      onTap: () => authController.changeTab("Register"),
                      child: buildTab("Register",
                          authController.tab.value == "Register", context),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
