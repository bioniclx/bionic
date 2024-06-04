/*

!!!IMPORTANT!!!
THIS IS A REUSEABLE WIDGET ANY CHANGE WILL BE INCLUDED IN ALL VIEW


*/
import 'package:bionic/app/components/custom_text.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:flutter/material.dart';

/*

Report card for showing detail income or prduk available
how to use : 
  When class called width are set infinity there you musrt call it using expanded
  or you can set width manually by using reportCardWidth variable
  for border color is set for 4 type of color you can get that by using setReportBorderColor()
*/

class CustomReportCard extends StatelessWidget {
  final String reportTitle;
  final int reportDetail;
  final double? reportCardWidth;
  final Color reportBorderColor;

  const CustomReportCard({
    super.key,
    required this.reportTitle,
    required this.reportDetail,
    this.reportCardWidth,
    required this.reportBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border(
            top: BorderSide(
              color: reportBorderColor,
              width: 15.0,
            ),
          ),
          color: Colors.white,
        ),
        width: reportCardWidth ?? double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: paddingMedium,
            horizontal: paddingMedium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: reportTitle,
                textSize: textMedium,
                textColor: Colors.black,
                textWeight: FontWeight.w500,
              ),
              const SizedBox(width: spaceMedium),
              CustomText(
                text: '$reportDetail',
                textSize: textLarge,
                textColor: Colors.black,
                textWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
