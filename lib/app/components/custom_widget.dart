import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double textSize;
  final Color textColor;
  final FontWeight textWeight;
  const CustomText({
    super.key,
    required this.text,
    required this.textSize,
    required this.textColor,
    required this.textWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: textSize,
          color: textColor,
          fontWeight: textWeight,
        ),
      ),
    );
  }
}
