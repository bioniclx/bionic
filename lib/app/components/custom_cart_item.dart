/*

!!!IMPORTANT!!!
THIS IS A REUSEABLE WIDGET ANY CHANGE WILL BE INCLUDED IN ALL VIEW


*/
import 'package:bionic/app/components/custom_text.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*

Custom Cart Item for adding new produk to cart for "History Pembelian" 
how to use : (Masih di kerjain)

*/

class CustomCartItem extends StatelessWidget {
  final Color itemColor;
  final String itemName;
  final String itemPrice;
  final RxInt itemCount;
  final Function() onMinus;
  final Function() onAdd;
  const CustomCartItem({
    super.key,
    required this.itemColor,
    required this.itemName,
    required this.itemPrice,
    required this.itemCount,
    required this.onMinus,
    required this.onAdd,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingMedium),
      child: Card(
        elevation: 8,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: spaceVerySmall,
              horizontal: paddingMedium,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/test.jpg',
                  height: 75.0,
                  width: 75.0,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: itemName,
                      textSize: textMedium,
                      textColor: Colors.black,
                      textWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: paddingSmall),
                    CustomText(
                      text: itemPrice,
                      textSize: 10,
                      textColor: Colors.grey,
                      textWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: paddingLarge),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            size: 15,
                          ),
                          onPressed: onMinus,
                        ),
                        const SizedBox(width: paddingMedium),
                        Obx(
                          () => CustomText(
                            text: '$itemCount',
                            textSize: textSmall,
                            textColor: Colors.black,
                            textWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: paddingMedium),
                        IconButton(
                          icon: const Icon(
                            Icons.add_circle_outline_sharp,
                            size: 15,
                          ),
                          onPressed: onAdd,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
