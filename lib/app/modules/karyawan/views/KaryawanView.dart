import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bionic/app/modules/karyawan/controllers/KaryawanController.dart';
import 'package:bionic/app/components/custom_text.dart';
import 'package:bionic/app/components/custom_text_field.dart';

class KaryawanView extends GetView<KaryawanController> {
  const KaryawanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Karyawan'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login-background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                color: Color.fromRGBO(183, 183, 183, 1),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.karyawanList.isEmpty) {
                    return Center(
                      child: CustomText(
                        text: 'Belum ada data karyawan.',
                        textSize: 14,
                        textColor: Colors.black,
                        textWeight: FontWeight.w400,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: controller.karyawanList.length,
                      itemBuilder: (context, index) {
                        var karyawan = controller.karyawanList[index];

                        // Handling null value
                        String fullName =
                            karyawan['fullName'] ?? 'Nama Tidak Tersedia';
                        String role =
                            karyawan['position'] ?? 'Posisi Tidak Tersedia';
                        String joinDate =
                            karyawan['register_at'] ?? 'Tanggal Tidak Tersedia';

                        return Card(
                          child: ListTile(
                            title: Text('$fullName'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Posisi: $role'),
                                Text('Tanggal Masuk: $joinDate'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () =>
                                  _showEditDeleteDialog(context, karyawan),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddKaryawanDialog(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showEditDeleteDialog(
      BuildContext context, Map<String, dynamic> karyawan) {
    TextEditingController fullNameController =
        TextEditingController(text: karyawan['fullName']);
    TextEditingController positionController =
        TextEditingController(text: karyawan['position']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit atau Hapus Karyawan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                textTitle: 'Nama Lengkap',
                textFieldController: fullNameController,
                textFieldType: TextInputType.name,
                obsecureText: false,
              ),
              CustomTextField(
                textTitle: 'Posisi',
                textFieldController: positionController,
                textFieldType: TextInputType.text,
                obsecureText: false,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                controller.deleteKaryawan(karyawan['uid']);
                Navigator.of(context).pop();
              },
              child: Text('Hapus', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                controller.updateKaryawan(
                  karyawan['uid'],
                  fullNameController.text,
                  positionController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showAddKaryawanDialog(BuildContext context) {
    controller.emailController.clear();
    controller.fullNameController.clear();
    controller.positionController.clear();
    controller.passwordController.clear();
    controller.confirmPasswordController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Karyawan'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  textTitle: 'Email',
                  textFieldController: controller.emailController,
                  textFieldType: TextInputType.emailAddress,
                  obsecureText: false,
                ),
                CustomTextField(
                  textTitle: 'Nama Lengkap',
                  textFieldController: controller.fullNameController,
                  textFieldType: TextInputType.name,
                  obsecureText: false,
                ),
                CustomTextField(
                  textTitle: 'Posisi',
                  textFieldController: controller.positionController,
                  textFieldType: TextInputType.text,
                  obsecureText: false,
                ),
                CustomTextField(
                  textTitle: 'Password',
                  textFieldController: controller.passwordController,
                  textFieldType: TextInputType.visiblePassword,
                  obsecureText: true,
                ),
                CustomTextField(
                  textTitle: 'Konfirmasi Password',
                  textFieldController: controller.confirmPasswordController,
                  textFieldType: TextInputType.visiblePassword,
                  obsecureText: true,
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
                controller.registerAccount(
                  email: controller.emailController.text,
                  fullName: controller.fullNameController.text,
                  position: controller.positionController.text,
                  password: controller.passwordController.text,
                  confirmPassword: controller.confirmPasswordController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Tambah'),
            ),
          ],
        );
      },
    );
  }
}
