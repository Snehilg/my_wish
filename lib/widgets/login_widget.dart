import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wish/controllers/auth_controller.dart';
import 'package:my_wish/utils.dart';

class LoginWidget extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 40, right: 40),
          height: 45,
          child: TextFormField(
            controller: emailController,
            style: textStyle(16, Colors.grey, FontWeight.w500),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[250],
              hintText: "Email",
              hintStyle: textStyle(16, Colors.grey, FontWeight.w500),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 40, right: 40),
          height: 45,
          child: TextFormField(
            controller: passwordController,
            style: textStyle(16, Colors.grey, FontWeight.w500),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[250],
              hintText: "Password",
              hintStyle: textStyle(16, Colors.grey, FontWeight.w500),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 45,
          child: TextButton(
            onPressed: () => authController.loginUser(
                emailController.text, passwordController.text),
            style: TextButton.styleFrom(backgroundColor: Colors.lightBlue),
            child: Text(
              "Login",
              style: textStyle(20, Colors.white, FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
