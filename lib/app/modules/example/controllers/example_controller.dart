import 'package:bionic/app/utils/utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ExampleController extends GetxController {
  final statusColor = getStatusColor(0);
  RxInt itemCount = 0.obs;
  var itemName = ['test', 'test2', 'test3'];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void logoutAccount() {
    FirebaseAuth.instance.signOut();
  }

  void increment() => itemCount.value++;
  void decrement() {
    if (itemCount.value > 0) {
      itemCount.value--;
    } else {}
  }
}
