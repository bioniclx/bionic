import 'package:bionic/app/components/custom_text.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:flutter/material.dart';

class CustomReportCategory extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final Function() onTap;
  const CustomReportCategory({
    super.key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: borderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(paddingSmall),
          child: Center(
            child: CustomText(
              text: text,
              textSize: textMedium,
              textColor: textColor,
              textWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
