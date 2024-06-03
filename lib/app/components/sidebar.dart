/*

Widget drawer for sidebar
How to use : 
  - call this widget on your context drawer
  - create key for scaffold
  - use this method to open or close drawer
    
    //open
    void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
    }

    //close
    void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
    }

*/
import 'package:bionic/app/components/custom_widget.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:flutter/material.dart';

class NavigationSidebar extends StatelessWidget {
  final Color? isActived1;
  final Color? isActived2;
  const NavigationSidebar({
    super.key,
    this.isActived1,
    this.isActived2,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeader(
            child: Center(
              child: CustomText(
                text: 'L O G O',
                textSize: textMedium,
                textColor: Colors.grey,
                textWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
