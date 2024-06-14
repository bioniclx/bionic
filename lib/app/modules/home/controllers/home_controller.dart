import 'package:bionic/app/utils/utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final statusColor = getStatusColor(1);
  RxInt itemCount = 0.obs;
  var itemName = ['test', 'test2', 'test3'];
  var storeId = FirebaseAuth.instance.currentUser?.uid;

  String? refreshUser() {
    FirebaseAuth.instance.authStateChanges().listen((currentUser) {
      storeId = currentUser?.uid;
    });
    return storeId;
  }

  @override
  void onInit() {
    super.onInit();
    refreshUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getStoreProfile() {
    return FirebaseFirestore.instance.collection('user').doc(storeId).get();
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
