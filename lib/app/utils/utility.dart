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

//List tile height
const double tileNormal = 30.0;
//text Size
const double textSmall = 10.0;
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

// make to color list of status
List<Color> statusColorList = [
  Color(0xff8d86c9),
  Color(0xff22577a),
  Color(0xff6eeb83),
  Color(0xff861657),
  Color(0xffdb5461),
  Color(0xff3e92cc),
  Color(0xff1b998b),
  Color(0xff8963ba),
  Color(0xffffb800),
  Color(0xff197bbd),
  Color(0xfffdf5bf),
  Color(0xffc04abc)
];

String getRoleAccount(String role) {
  if (role == "1") {
    return "Owner";
  } else if (role == "2") {
    return "Karyawan";
  } else {
    return "Invalid";
  }
}

Color activatedCategoryBackground(int isActivated, int index) {
  if (isActivated == index) {
    return primary;
  } else {
    return Colors.white;
  }
}

Color activatedCategoryText(int isActivated, int index) {
  if (isActivated == index) {
    return Colors.white;
  } else {
    return primary;
  }
}

Color setReportBorderColor(int type) {
  if (type == 0) {
    return primary;
  } else if (type == 1) {
    return Colors.green;
  } else if (type == 2) {
    return const Color.fromRGBO(34, 182, 228, 1);
  } else {
    return const Color.fromRGBO(163, 188, 249, 1);
  }
}
