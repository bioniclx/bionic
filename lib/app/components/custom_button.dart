/*

!!!IMPORTANT!!!
THIS IS A REUSEABLE WIDGET ANY CHANGE WILL BE INCLUDED IN ALL VIEW


*/
import 'package:bionic/app/utils/utility.dart';
import 'package:flutter/material.dart';

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
          backgroundColor: primary,
          foregroundColor: Colors.white,
        ),
        onPressed: onTap,
        child: Text(buttonText),
      ),
    );
  }
}
