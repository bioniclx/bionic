import 'package:bionic/app/components/custom_button.dart';
import 'package:bionic/app/components/custom_text.dart';
import 'package:bionic/app/components/custom_text_field.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login-background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: spaceMedium,
            vertical: spaceSmall,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'WELCOME!',
                textSize: textExtraLarge,
                textColor: Colors.black,
                textWeight: FontWeight.w400,
              ),
              const Align(
                alignment: Alignment.center,
                child: CustomText(
                  text: 'SELAMAT BERGABUNG,',
                  textSize: textMedium,
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
                          width: textFieldWidthLarge,
                          child: CustomTextField(
                            textTitle: 'Email',
                            textFieldController: controller.emailController,
                            textFieldType: TextInputType.name,
                            obsecureText: false,
                          ),
                        ),
                        const SizedBox(height: spaceSmall),
                        SizedBox(
                          width: textFieldWidthLarge,
                          child: CustomTextField(
                            textTitle: 'Nama Toko',
                            textFieldController: controller.storeNameController,
                            textFieldType: TextInputType.name,
                            obsecureText: false,
                          ),
                        ),
                        const SizedBox(height: spaceSmall),
                        SizedBox(
                          width: textFieldWidthLarge,
                          child: CustomTextField(
                            textTitle: 'Password',
                            textFieldController: controller.passwordController,
                            textFieldType: TextInputType.name,
                            obsecureText: true,
                          ),
                        ),
                        const SizedBox(height: spaceSmall),
                        SizedBox(
                          width: textFieldWidthLarge,
                          child: CustomTextField(
                            textTitle: 'Confirm Password',
                            textFieldController:
                                controller.confirmPasswordController,
                            textFieldType: TextInputType.name,
                            obsecureText: true,
                          ),
                        ),
                        const SizedBox(height: spaceExtraLarge),
                        CustomButton(
                          buttonText: 'Register',
                          buttonWidth: 150,
                          buttonHeight: 50,
                          onTap: () {
                            controller.registerAccouhnt(
                              controller.emailController.text,
                              controller.storeNameController.text,
                              controller.passwordController.text,
                              controller.confirmPasswordController.text,
                            );
                          },
                        ),
                        const SizedBox(height: spaceVerySmall),
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
                                controller.textLoginclicked();
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
    );
  }
}
