/*

!!!IMPORTANT!!!
THIS IS A REUSEABLE WIDGET ANY CHANGE WILL BE INCLUDED IN ALL VIEW


*/
import 'package:bionic/app/components/custom_text.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:flutter/material.dart';

/*

Custom List Item for list view
How to use : (Still workin on it)

*/

class CustomListItem extends StatelessWidget {
  final String itemName;
  final String itemDate;
  final String itemPrice;
  final Color itemColor;
  const CustomListItem({
    super.key,
    required this.itemName,
    required this.itemDate,
    required this.itemPrice,
    required this.itemColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border(
            left: BorderSide(
              color: itemColor,
              width: 15.0,
            ),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: spaceVerySmall,
            horizontal: paddingMedium,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: itemName,
                    textSize: 20,
                    textColor: Colors.black,
                    textWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 23),
                  CustomText(
                    text: itemDate,
                    textSize: 12,
                    textColor: Colors.grey,
                    textWeight: FontWeight.w400,
                  ),
                ],
              ),
              CustomText(
                text: itemPrice,
                textSize: 16,
                textColor: Colors.black,
                textWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
