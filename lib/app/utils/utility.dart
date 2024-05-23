/*

!!!UTILITY!!!
Gak begitu penting tapi biar rapih aja 

*/

import 'package:flutter/material.dart';

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
