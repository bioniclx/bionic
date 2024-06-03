/*

!!!IMPORTANT!!!
THIS IS A REUSEABLE WIDGET ANY CHANGE WILL BE INCLUDED IN ALL VIEW


*/

import 'package:bionic/app/utils/utility.dart';
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
          backgroundColor: primary,
          foregroundColor: Colors.white,
        ),
        onPressed: onTap,
        child: Text(buttonText),
      ),
    );
  }
}

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
