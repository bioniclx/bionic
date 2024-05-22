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

/*
Custom Text and Text Field you can use for all condition
how to use : (Ntar dulu)

*NOTE : Not yet added function for showing and hiding password

*/

class CustomTextField extends StatelessWidget {
  final String textTitle;
  final TextEditingController textFieldController;
  final TextInputType textFieldType;
  final bool obsecureText;
  const CustomTextField({
    super.key,
    required this.textTitle,
    required this.textFieldController,
    required this.textFieldType,
    required this.obsecureText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            textTitle,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(54, 183, 189, 1),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 11,
        ),
        TextField(
          controller: textFieldController,
          keyboardType: textFieldType,
          obscureText: obsecureText,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(212, 212, 212, 1),
              ),
            ),
            fillColor: Color.fromRGBO(240, 243, 248, 1),
            filled: true,
          ),
        ),
      ],
    );
  }
}

/*
Custom Button with rounded corner
How to use : 
  you can customize height and widthin views
  make on tap function and put your code there
*/

class CustomButton extends StatelessWidget {
  final String buttonText;
  final double buttonWidth;
  final double? buttonHeight;
  final Function()? onTap;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    required this.buttonWidth,
    this.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: const Color.fromRGBO(54, 183, 189, 1),
          foregroundColor: Colors.white,
        ),
        onPressed: onTap,
        child: Text(buttonText),
      ),
    );
  }
}
