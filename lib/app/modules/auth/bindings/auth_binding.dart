import 'package:bionic/app/modules/home/controllers/home_controller.dart';
import 'package:bionic/app/modules/login/controllers/login_controller.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => HomeController());
  }
}
