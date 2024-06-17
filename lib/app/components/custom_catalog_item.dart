import 'package:bionic/app/components/custom_text.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCatalogItem extends StatelessWidget {
  final String productName;
  final int productPrice;
  final String productCategory;
  final int productStock;
  final String productImage;
  final Function()? onTap;
  const CustomCatalogItem({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productCategory,
    required this.productStock,
    this.onTap,
    required this.productImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(paddingSmall),
              child: GestureDetector(
                onTap: onTap,
                child: const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 243, 127, 118),
                  child: Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: productImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: spaceVerySmall),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: productName,
                      textSize: textMedium,
                      textColor: Colors.black,
                      textWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: paddingVerySmall),
                    CustomText(
                      text: '$productPrice',
                      textSize: textSmall,
                      textColor: Colors.black,
                      textWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: paddingSmall),
                    const SizedBox(
                      width: 150,
                      height: 60,
                      child: CustomText(
                        text:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam sit amet pretium sem, at cursus dolor. Donec et ligula faucibus, cursus neque in, sodales ante. Fusce pretium vestibulum nulla et consectetur.',
                        textSize: textSmall,
                        textColor: Colors.black,
                        textWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
