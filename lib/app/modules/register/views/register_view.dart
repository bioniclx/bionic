import 'package:bionic/app/components/custom_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButtonWithIcon(
              buttonText: 'Laporan \nPenjualan',
              buttonIcon: Icons.add,
              buttonHeight: 120,
              buttonWidth: 120,
            ),
          ],
        ),
      ),
    );
  }
}
