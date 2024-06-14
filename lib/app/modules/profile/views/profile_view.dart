import 'package:bionic/app/routes/app_pages.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bionic/app/modules/profile/controllers/profile_controller.dart';
import 'package:bionic/app/components/custom_report_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileView extends GetView<ProfileController> {
  static const primaryColor = Color(0xFF36B7BD);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.toNamed(Routes.HOME); // Navigate to the home page
          },
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            Container(
              color: primaryColor,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Elang',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Admin',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.yellow,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),

            // Profile body
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Laporan Penjualan',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CustomReportCard(
                            reportTitle: 'Penjualan Minggu Ini',
                            reportDetail: 1500,
                            reportBorderColor: Colors.blue,
                            reportCardWidth: 150, // Set a default width
                          ),
                          SizedBox(width: 10), // Add spacing between cards
                          CustomReportCard(
                            reportTitle: 'Penjualan Bulan Ini',
                            reportDetail: 5000,
                            reportBorderColor: Colors.green,
                            reportCardWidth: 150, // Set a default width
                          ),
                          SizedBox(width: 10), // Add spacing between cards
                          CustomReportCard(
                            reportTitle: 'Penjualan Tahun Ini',
                            reportDetail: 60000,
                            reportBorderColor: Colors.orange,
                            reportCardWidth: 150, // Set a default width
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    buildButton('Karyawan', primaryColor, () {
                      Get.toNamed(Routes.KARYAWAN);
                    }),
                    buildButton('Edit Profile', primaryColor, () {
                      showEditProfileDialog(context);
                    }),
                    buildButton('Ganti Kata Sandi', primaryColor, () {
                      showChangePasswordDialog(context);
                    }),
                    buildButton('Logout', Colors.red, () {
                      _auth.signOut();
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController emailController = TextEditingController();
        TextEditingController storeNameController = TextEditingController();

        return AlertDialog(
          title: Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: storeNameController,
                  decoration: InputDecoration(labelText: 'Store Name'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _updateProfile(
                    emailController.text, storeNameController.text);
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateProfile(String newEmail, String newStoreName) async {
    try {
      await _auth.currentUser!.updateEmail(newEmail);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update({
        'email': newEmail,
        'store_name': newStoreName,
      });
    } catch (e) {
      print('Error updating profile: $e');
    }
  }

  void showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ganti Kata Sandi'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Kata Sandi Lama'),
                  obscureText: true,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Kata Sandi Baru'),
                  obscureText: true,
                ),
                TextField(
                  decoration:
                      InputDecoration(labelText: 'Konfirmasi Kata Sandi Baru'),
                  obscureText: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Widget buildButton(String text, Color color, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: color,
          minimumSize: Size(double.infinity, 50),
          side: BorderSide(
            color: color,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
