/*

!!!IMPORTANT!!!
THIS IS A REUSEABLE WIDGET ANY CHANGE WILL BE INCLUDED IN ALL VIEW


*/
import 'package:bionic/app/components/custom_text.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:flutter/material.dart';

/*

Custom button with image using card for shadow
How to use : 
  Call this class and set all the required data
  if the text align are left make sure the box are big enough for your text

  NOTE : you can either change the elevation and size or not
  
*/

class CustomButtonWithIcon extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  final double buttonHeight;
  final double buttonWidth;
  final double? buttonElevation;
  final double? buttonIconSize;
  final Function()? onTap;
  const CustomButtonWithIcon({
    super.key,
    required this.buttonText,
    required this.buttonIcon,
    required this.buttonHeight,
    required this.buttonWidth,
    this.buttonElevation,
    this.buttonIconSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: buttonElevation ?? 8,
        child: Container(
          height: buttonHeight,
          width: buttonWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    buttonIcon,
                    color: const Color.fromRGBO(54, 183, 189, 1),
                    size: buttonIconSize ?? 52,
                  ),
                ),
              ),
              const SizedBox(height: spaceVerySmall),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    child: FittedBox(
                      child: CustomText(
                        text: buttonText,
                        textSize: 12,
                        textColor: const Color.fromRGBO(54, 183, 189, 1),
                        textWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
