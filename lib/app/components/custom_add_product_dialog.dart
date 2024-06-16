import 'dart:io';

import 'package:bionic/app/components/custom_button.dart';
import 'package:bionic/app/components/custom_text.dart';
import 'package:bionic/app/components/custom_text_field.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CustomAddProductDialog extends StatelessWidget {
  final TextEditingController productName;
  final TextEditingController productStock;
  final TextEditingController productCategory;
  final TextEditingController productPrice;
  final Rx<XFile> image;
  final Function()? onTap;
  final Function()? getImage;
  const CustomAddProductDialog({
    super.key,
    required this.productName,
    required this.productStock,
    required this.productCategory,
    required this.productPrice,
    required this.image,
    this.onTap,
    this.getImage,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Dialog(
          child: Container(
            width: 430,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(217, 217, 217, 1),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: paddingMedium,
                vertical: paddingMedium,
              ),
              child: Column(
                children: [
                  const CustomText(
                    text: 'Edit',
                    textSize: textMedium,
                    textColor: primary,
                    textWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: spaceMedium),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        image.value.path == ""
                            ? GestureDetector(
                                onTap: getImage,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: primary),
                                  ),
                                  child: const Icon(
                                    Icons.add_a_photo_outlined,
                                    color: primary,
                                    size: 48,
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.file(
                                  File(image.value.path),
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.fill,
                                ),
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(height: spaceSmall),
                  CustomTextField(
                    textTitle: 'Nama',
                    textFieldController: productName,
                    textFieldType: TextInputType.name,
                    obsecureText: false,
                  ),
                  const SizedBox(height: spaceVerySmall),
                  CustomTextField(
                    textTitle: 'Stok',
                    textFieldController: productStock,
                    textFieldType: TextInputType.name,
                    obsecureText: false,
                  ),
                  const SizedBox(height: spaceVerySmall),
                  CustomTextField(
                    textTitle: 'Kategori',
                    textFieldController: productCategory,
                    textFieldType: TextInputType.name,
                    obsecureText: false,
                  ),
                  const SizedBox(height: spaceVerySmall),
                  CustomTextField(
                    textTitle: 'Harga',
                    textFieldController: productPrice,
                    textFieldType: TextInputType.name,
                    obsecureText: false,
                  ),
                  const SizedBox(height: spaceMedium),
                  CustomButton(
                    buttonText: 'Simpan',
                    buttonWidth: 150,
                    buttonHeight: 50,
                    onTap: onTap,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
