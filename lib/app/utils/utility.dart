/*

!!!UTILITY!!!
Gak begitu penting tapi biar rapih aja 

*/

import 'package:flutter/material.dart';

/*

Custom 

*/

//color
const Color primary = Color.fromRGBO(54, 183, 189, 1);

//text Size
const double textSmall = 8.0;
const double textMedium = 16.0;
const double textLarge = 32.0;
const double textExtraLarge = 64.0;

//text field width use it on sized box
const double textFieldWidthLarge = 266;
const double textFieldWidthMedium = 200;

//button width and height

//Spacing widget
const double spaceVerySmall = 10.0;
const double spaceSmall = 20.0;
const double spaceMedium = 30.0;
const double spaceLarge = 40.0;
const double spaceExtraLarge = 80;

//Spacing padding
const double paddingVerySmall = 4.0;
const double paddingSmall = 8.0;
const double paddingMedium = 16.0;
const double paddingLarge = 32.0;
const double paddingExtraLarge = 64.0;

/*

Get status color by status transaction

*/
Color getStatusColor(int status) {
  if (status == 0) {
    return Colors.red;
  } else {
    return Colors.green;
  }
}
