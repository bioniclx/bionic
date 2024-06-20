import 'package:bionic/app/components/custom_button_icon.dart';
import 'package:bionic/app/components/custom_text.dart';
import 'package:bionic/app/components/sidebar.dart';
import 'package:bionic/app/modules/history/views/historypage.dart';
import 'package:bionic/app/routes/app_pages.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key})
      : super(key: key); // Perbaiki super.key menjadi Key? key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: FutureBuilder(
        future: controller.getStoreProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            Map<String, dynamic>? store = snapshot.data!.data();
            return NavigationSidebar(
              storeName: "${store!['store_name']}",
              role: getRoleAccount(store['role']),
            );
          } else {
            return const Text('Has no data');
          }
        },
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: primary,
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Image.asset('assets/images/side-bar-icon.png'),
              ),
            ),
            title: Row(
              children: [
                Image.asset('assets/images/logo.png'),
              ],
            ),
          ),
        ],
        scrollDirection: Axis.vertical,
        body: Column(
          // Mengubah ListView menjadi Column
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: spaceExtraLarge,
                  decoration: const BoxDecoration(color: primary),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: paddingLarge),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtonWithIcon(
                        buttonText: 'Penjualan',
                        buttonIcon: Icons.arrow_right_alt_outlined,
                        buttonHeight: 110,
                        buttonWidth: 110,
                        onTap: () {
                          Get.toNamed(Routes.SALES);
                        },
                      ),
                      CustomButtonWithIcon(
                        buttonText: 'Tambah Produk',
                        buttonIcon: Icons.add,
                        buttonHeight: 110,
                        buttonWidth: 110,
                        onTap: () {
                          Get.toNamed(Routes.ADD_PRODUCT);
                        },
                      ),
                      const CustomButtonWithIcon(
                        buttonText: 'Laporan \nPenjualan',
                        buttonIcon: Icons.bar_chart_rounded,
                        buttonTextPaddingVertical: 10.0,
                        buttonHeight: 110,
                        buttonWidth: 110,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: paddingLarge,
                vertical: paddingMedium,
              ),
              child: CustomText(
                text: 'History Penjualan',
                textSize: textMedium,
                textColor: Colors.black,
                textWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              // Menggunakan Expanded untuk memastikan HistoryPage mengambil sebanyak mungkin ruang vertikal
              child: HistoryPage(),
            ),
          ],
        ),
      ),
    );
  }
}
