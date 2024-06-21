import 'dart:io';
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
    } catch (e) {
      print('Error updating profile: $e');
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
      print('Error uploading profile image: $e');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.toNamed(Routes.HOME);
          },
        ),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("Error loading user data"));
          }
          String name = snapshot.data!['store_name'] ?? 'User';
          String roleString = snapshot.data!['role'] ?? '2';
          int role = int.tryParse(roleString) ?? 2;
          String roleName = role == 1 ? 'Admin' : 'Karyawan';
          String? photoUrl = snapshot.data!['photo_url'];
          String email = snapshot.data!['email'] ?? '';

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: primaryColor,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage:
                            photoUrl != null ? NetworkImage(photoUrl) : null,
                        child: photoUrl == null
                            ? Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.grey.shade700,
                              )
                            : null,
                      ),
                      SizedBox(height: 10),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        roleName,
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
                        if (role == 2) ...[
                          Text(
                            'Laporan Penjualan Hari Ini',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(height: 20),
                          CustomReportCard(
                            reportTitle: 'Penjualan Hari Ini',
                            reportDetail: 150,
                            reportBorderColor: Colors.blue,
                            reportCardWidth: 150,
                          ),
                          SizedBox(height: 40),
                        ] else ...[
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
                                  reportCardWidth: 150,
                                ),
                                SizedBox(width: 10),
                                CustomReportCard(
                                  reportTitle: 'Penjualan Bulan Ini',
                                  reportDetail: 5000,
                                  reportBorderColor: Colors.green,
                                  reportCardWidth: 150,
                                ),
                                SizedBox(width: 10),
                                CustomReportCard(
                                  reportTitle: 'Penjualan Tahun Ini',
                                  reportDetail: 60000,
                                  reportBorderColor: Colors.orange,
                                  reportCardWidth: 150,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          buildButton('Karyawan', primaryColor, () {
                            Get.toNamed(Routes.KARYAWAN);
                          }),
                        ],
                        buildButton('Edit Profile', primaryColor, () {
                          showEditProfileDialog(context, email, name);
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
          );
        },
      ),
    );
  }

  void showEditProfileDialog(
      BuildContext context, String currentEmail, String currentStoreName) {
    TextEditingController emailController =
        TextEditingController(text: currentEmail);
    TextEditingController storeNameController =
        TextEditingController(text: currentStoreName);

    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    await _pickAndUploadProfileImage(
                        context, emailController, storeNameController);
                  },
                  child: Text('Pilih Foto Profil'),
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
                    emailController.text, storeNameController.text, null);
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
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
