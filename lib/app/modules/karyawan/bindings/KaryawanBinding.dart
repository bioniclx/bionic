import 'package:bionic/app/modules/karyawan/controllers/KaryawanController.dart';
import 'package:get/get.dart';

class KaryawanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KaryawanController>(() => KaryawanController());
  }
}
