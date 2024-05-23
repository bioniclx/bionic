import 'package:bionic/app/components/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login-background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'HELLO!',
                  textSize: 64,
                  textColor: Colors.black,
                  textWeight: FontWeight.w400,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: CustomText(
                    text: 'Selamat Datang,',
                    textSize: 16,
                    textColor: Colors.black,
                    textWeight: FontWeight.w400,
                  ),
                ),
                const Divider(
                  color: Color.fromRGBO(183, 183, 183, 1),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 266,
                            child: CustomTextField(
                              textTitle: 'Email',
                              textFieldController: controller.emailController,
                              textFieldType: TextInputType.name,
                              obsecureText: false,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 266,
                            child: CustomTextField(
                              textTitle: 'Email',
                              textFieldController: controller.emailController,
                              textFieldType: TextInputType.name,
                              obsecureText: false,
                            ),
                          ),
                          const SizedBox(height: 80),
                          CustomButton(
                            onTap: () {},
                            buttonText: 'Submit',
                            buttonWidth: 150,
                            buttonHeight: 50,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CustomText(
                                text: 'Anda Belum Memiliki Akun?',
                                textSize: 11,
                                textColor: Colors.black,
                                textWeight: FontWeight.w400,
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                child: const CustomText(
                                  text: 'Daftar',
                                  textSize: 14,
                                  textColor: Color.fromRGBO(15, 155, 71, 1),
                                  textWeight: FontWeight.w400,
                                ),
                                onTap: () {
                                  controller.textRegisClicked();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
