import 'package:bionic/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  final text = "Kelola toko mu dengan \nmudah!";
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes.LOGIN);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
