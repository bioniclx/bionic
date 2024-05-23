import 'package:bionic/app/components/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      body: Center(
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return CustomListItem(
              itemName: 'Endriardi',
              itemDate: '20 Mei 2024',
              itemPrice: 'Rp. 2.400.00',
              itemColor: controller.statusColor,
            );
          },
        ),
      ),
    );
  }
}
