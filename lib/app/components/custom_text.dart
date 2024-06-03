/*

!!!IMPORTANT!!!
THIS IS A REUSEABLE WIDGET ANY CHANGE WILL BE INCLUDED IN ALL VIEW


*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/*
Custom Text with poppins fonts style
how to use : 
  call CustomText and customize text,size,color,weight from context view
*/

class CustomText extends StatelessWidget {
  final String text;
  final double textSize;
  final Color textColor;
  final FontWeight textWeight;
  final TextAlign? textAlign;
  const CustomText({
    super.key,
    required this.text,
    required this.textSize,
    required this.textColor,
    required this.textWeight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
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
