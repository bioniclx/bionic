import 'package:bionic/app/models/sales.dart';
import 'package:bionic/app/utils/utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final statusColor = getStatusColor(1);
  RxInt itemCount = 0.obs;
  var itemName = ['test', 'test2', 'test3'];
  var userId = FirebaseAuth.instance.currentUser?.uid;
  var storeId = ''.obs;
  String? refreshUser() {
    FirebaseAuth.instance.authStateChanges().listen((currentUser) {
      userId = currentUser?.uid;
      if (userId != null) {
        fetchStoreId(); // Fetch store ID when user is refreshed
      } else {
        storeId.value = userId.toString();
      }
    });
    return userId;
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
    return FirebaseFirestore.instance.collection('user').doc(userId).get();
  }

  void fetchStoreId() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userDoc = await getStoreProfile();
        if (userDoc.exists && userDoc.data() != null) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          if (userData.containsKey('store_id')) {
            storeId.value = userData['store_id'];
          }
        }
      }
    } catch (e) {
      // Handle error
      print("Error fetching store ID: $e");
    }
  }

  void logoutAccount() {
    FirebaseAuth.instance.signOut();
  }

  Stream<List<Sales>> getSales() {
    return FirebaseFirestore.instance
        .collection('sales')
        .where("store_id", isEqualTo: storeId.value)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Sales.fromJson(doc.data())).toList());
  }

  void increment() => itemCount.value++;
  void decrement() {
    if (itemCount.value > 0) {
      itemCount.value--;
    } else {}
  }
}
