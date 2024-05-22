import 'package:flutter/material.dart';
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
