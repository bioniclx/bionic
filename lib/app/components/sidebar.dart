/*

Widget drawer for sidebar
How to use : 
  - call this widget on your context drawer
  - open drawer by calling a scaffold context and open drawer
    Scaffold.of(context).openDrawer();
*/

import 'package:bionic/app/components/custom_text.dart';
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
        children: [
          const DrawerHeader(
            child: Center(
              child: CustomText(
                text: 'P R O F I L E',
                textSize: textMedium,
                textColor: Colors.grey,
                textWeight: FontWeight.w800,
              ),
            ),
          ),
          ListTile(
            tileColor: Colors.blue[100],
            title: const Text('Page 1'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Page 2'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
