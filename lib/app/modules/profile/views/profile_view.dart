import 'dart:io';
import 'package:bionic/app/components/custom_snackbar.dart';
import 'package:bionic/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bionic/app/modules/profile/controllers/profile_controller.dart';
import 'package:bionic/app/components/custom_report_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends GetView<ProfileController> {
  static const primaryColor = Color(0xFF36B7BD);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  Future<Map<String, dynamic>> _getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData =
          await _firestore.collection('user').doc(user.uid).get();
      return userData.data() as Map<String, dynamic>;
    }
    return {};
  }

  Future<void> _updateProfile(
      String newEmail, String newStoreName, String? photoUrl) async {
    try {
      if (newEmail.isNotEmpty) {
        await _auth.currentUser!.updateEmail(newEmail);
      }
      Map<String, dynamic> updatedData = {
        'email': newEmail,
        'store_name': newStoreName,
      };
      if (photoUrl != null) {
        updatedData['photo_url'] = photoUrl;
      }
      await _firestore
          .collection('user')
          .doc(_auth.currentUser!.uid)
          .update(updatedData);
      showSuccessSnackbar('Success', 'Profile updated successfully');
    } catch (e) {
      showErrorSnackbar('Error', 'Error updating profile: $e');
    }
  }

  Future<String?> _uploadProfileImage(File imageFile) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String filePath = 'profile_images/${user.uid}.png';
        TaskSnapshot uploadTask =
            await _storage.ref(filePath).putFile(imageFile);
        return await uploadTask.ref.getDownloadURL();
      }
    } catch (e) {
      showErrorSnackbar('Error', 'Error uploading profile image: $e');
    }
    return null;
  }

  Future<void> _pickAndUploadProfileImage(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController storeNameController) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String? photoUrl = await _uploadProfileImage(imageFile);
      if (photoUrl != null) {
        await _updateProfile(
            emailController.text, storeNameController.text, photoUrl);
        Navigator.of(context).pop();
      }
    }
  }

  int calculateTotalItems(List<Map<String, dynamic>> salesData) {
    int totalItems = 0;
    for (var sale in salesData) {
      List<dynamic> products = sale['products'];
      totalItems +=
          products.fold<int>(0, (sum, item) => sum + (item['qty'] as int));
    }
    return totalItems;
  }

  double calculateTotalRevenue(List<Map<String, dynamic>> salesData) {
    double totalRevenue = 0;
    for (var sale in salesData) {
      totalRevenue += double.parse(sale['total']);
    }
    return totalRevenue;
  }

  List<Map<String, dynamic>> filterSalesByDate(
      List<Map<String, dynamic>> salesData,
      DateTime startDate,
      DateTime endDate) {
    return salesData.where((sale) {
      Timestamp saleTimestamp = sale['created_at'];
      DateTime saleDate = saleTimestamp.toDate();
      return saleDate.isAfter(startDate) && saleDate.isBefore(endDate);
    }).toList();
  }

  Future<List<Map<String, dynamic>>> _getSalesData(String storeId) async {
    QuerySnapshot salesSnapshot = await _firestore
        .collection('sales')
        .where('store_id', isEqualTo: storeId)
        .get();
    return salesSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  Future<List<Map<String, dynamic>>> _getEmployees() async {
    QuerySnapshot employeesSnapshot =
        await _firestore.collection('user').where('role', isEqualTo: '2').get();
    return employeesSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: FutureBuilder<Map<String, dynamic>>(
          future: _getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text("Error loading user data"));
            }
            String name = snapshot.data!['store_name'] ?? 'fullName';
            String storeId = snapshot.data!['store_id'] ?? '';
            String roleString = snapshot.data!['role'] ?? '2';
            int role = int.tryParse(roleString) ?? 2;
            String roleName = role == 1 ? 'Admin' : 'Karyawan';
            String? photoUrl = snapshot.data!['photo_url'];
            String email = snapshot.data!['email'] ?? '';

            return FutureBuilder<List<Map<String, dynamic>>>(
              future: _getSalesData(storeId),
              builder: (context, salesSnapshot) {
                if (salesSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!salesSnapshot.hasData || salesSnapshot.data == null) {
                  return const Center(child: Text("Error loading sales data"));
                }
                List<Map<String, dynamic>> salesData = salesSnapshot.data!;

                DateTime now = DateTime.now();
                List<Map<String, dynamic>> dailySales = filterSalesByDate(
                    salesData, now.subtract(const Duration(days: 1)), now);
                List<Map<String, dynamic>> monthlySales = filterSalesByDate(
                    salesData, DateTime(now.year, now.month, 1), now);

                int totalItems = calculateTotalItems(salesData);
                double totalRevenue = calculateTotalRevenue(salesData);

                int dailyItems = calculateTotalItems(dailySales);
                double dailyRevenue = calculateTotalRevenue(dailySales);

                double monthlyRevenue = calculateTotalRevenue(monthlySales);

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: primaryColor,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage: photoUrl != null
                                  ? NetworkImage(photoUrl)
                                  : null,
                              child: photoUrl == null
                                  ? Icon(
                                      Icons.person,
                                      size: 100,
                                      color: Colors.grey.shade700,
                                    )
                                  : null,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              roleName,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.yellow,
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        // height: Get.height / 1.5,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              if (role == 2) ...[
                                const Text(
                                  'Laporan Penjualan Hari Ini',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                CustomReportCard(
                                  reportTitle: 'Penjualan Hari Ini',
                                  reportDetail: dailyRevenue.toInt(),
                                  reportBorderColor: Colors.blue,
                                  reportCardWidth: 200,
                                ),
                                CustomReportCard(
                                  reportTitle: 'Item Terjual Hari Ini',
                                  reportDetail: dailyItems,
                                  reportBorderColor: Colors.blue,
                                  reportCardWidth: 200,
                                ),
                                const SizedBox(height: 40),
                              ] else ...[
                                const Text(
                                  'Laporan Penjualan',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10),
                                      CustomReportCard(
                                        reportTitle: 'Total Item Terjual',
                                        reportDetail: totalItems,
                                        reportBorderColor: Colors.purple,
                                        reportCardWidth: 200,
                                      ),
                                      CustomReportCard(
                                        reportTitle: 'Penjualan Hari Ini',
                                        reportDetail: dailyRevenue.toInt(),
                                        reportBorderColor: Colors.blue,
                                        reportCardWidth: 200,
                                      ),
                                      CustomReportCard(
                                        reportTitle: 'Penjualan Bulanan',
                                        reportDetail: monthlyRevenue.toInt(),
                                        reportBorderColor: Colors.orange,
                                        reportCardWidth: 200,
                                      ),
                                      const SizedBox(width: 10),
                                      CustomReportCard(
                                        reportTitle: 'Total Penjualan',
                                        reportDetail: totalRevenue.toInt(),
                                        reportBorderColor: Colors.red,
                                        reportCardWidth: 200,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40),
                                buildButton('Karyawan', primaryColor, () {
                                  Get.toNamed(Routes.KARYAWAN);
                                }),
                              ],
                              buildButton('Edit Profil', primaryColor, () {
                                _showEditProfileDialog(
                                    context, email, name, photoUrl);
                              }),
                              buildButton('Logout', primaryColor, () {
                                FirebaseAuth.instance.signOut();
                                Get.toNamed(Routes.AUTH);
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showEditProfileDialog(
      BuildContext context, String email, String name, String? photoUrl) {
    TextEditingController emailController = TextEditingController(text: email);
    TextEditingController storeNameController =
        TextEditingController(text: name);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                if (photoUrl != null)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(photoUrl),
                  ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: storeNameController,
                  decoration: const InputDecoration(labelText: 'Nama Toko'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _pickAndUploadProfileImage(
                    context, emailController, storeNameController);
              },
              child: const Text('Ubah Foto Profil'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                await _updateProfile(
                    emailController.text, storeNameController.text, null);
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Widget buildButton(String text, Color color, VoidCallback onClicked) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size.fromHeight(40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
        onPressed: onClicked,
      ),
    );
  }
}
