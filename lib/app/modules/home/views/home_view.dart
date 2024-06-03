import 'package:bionic/app/components/custom_widget.dart';
import 'package:bionic/app/components/sidebar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationSidebar(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.list)),
        ),
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 500,
              child: Center(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return CustomListItem(
                      itemName: 'Endriardi',
                      itemDate: '20 Mei 2024',
                      itemPrice: 'Rp. 2.400.00',
                      itemColor: controller.statusColor,
                    );
                  },
                ),
              ),
            ),
            CustomButton(
              buttonText: 'Logout',
              buttonWidth: 100,
              onTap: () {
                controller.logoutAccount();
              },
            ),
          ],
        ),
      ),
    );
  }
}
