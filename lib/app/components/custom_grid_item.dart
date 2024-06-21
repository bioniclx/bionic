import 'package:bionic/app/components/custom_text.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:flutter/material.dart';

class CustomGridItem extends StatelessWidget {
  final String name;
  final String price;
  final String stock;
  const CustomGridItem({
    super.key,
    required this.name,
    required this.price,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(paddingVerySmall),
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.blue[200],
            ),
            child: ClipRRect(
              child: Image.asset(
                "assets/images/produk-1.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(152, 152, 152, 0.7),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: paddingSmall,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Nama: $name",
                      textSize: textSmall,
                      textColor: Colors.black,
                      textWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: paddingVerySmall),
                    CustomText(
                      text: "Total: $price",
                      textSize: textSmall,
                      textColor: Colors.black,
                      textWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: paddingVerySmall),
                    CustomText(
                      text: "Jumlah: $stock",
                      textSize: textSmall,
                      textColor: Colors.black,
                      textWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
