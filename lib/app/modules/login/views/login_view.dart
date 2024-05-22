import 'package:bionic/app/components/custom_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login-background.jpg'),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  textTitle: 'Email',
                  textFieldController: controller.emailController,
                  textFieldType: TextInputType.name,
                  obsecureText: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
