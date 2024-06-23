import 'package:bionic/app/models/sale.dart';
import 'package:bionic/app/routes/app_pages.dart';
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
  var roleUser = ''.obs;
  bool isOwner = true;
  String? refreshUser() {
    FirebaseAuth.instance.authStateChanges().listen((currentUser) {
      userId = currentUser?.uid;
      if (userId != null) {
        fetchStoreId(FirebaseAuth
            .instance.currentUser); // Fetch store ID when user is refreshed
      } else {
        storeId.value = userId.toString();
      }
    });
    return userId;
  }

  @override
  void onInit() {
    super.onInit();
    fetchStoreId(FirebaseAuth.instance.currentUser);
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

  void fetchStoreId(User? currentUser) async {
    try {
      if (currentUser != null) {
        DocumentSnapshot userDoc = await getStoreProfile();
        if (userDoc.exists && userDoc.data() != null) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          if (userData.containsKey('store_id')) {
            storeId.value = userData['store_id'];
            roleUser.value = userData['role'];
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

  Stream<QuerySnapshot<Map<String, dynamic>>> getSales() {
    return FirebaseFirestore.instance
        .collection('sales')
        .where("store_id", isEqualTo: storeId.value)
        .orderBy("created_at", descending: true)
        .limit(5)
        .snapshots();
  }

  //change query data to list
  List<Sale> sales(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map(
      (doc) {
        return Sale.fromJson(doc.data());
      },
    ).toList();
  }

  void increment() => itemCount.value++;
  void decrement() {
    if (itemCount.value > 0) {
      itemCount.value--;
    } else {}
  }

  bool checkUserRole() {
    if (roleUser.value == "1") {
      return isOwner = true;
    }
    if (roleUser.value == "2") {
      return isOwner = false;
    } else {
      return isOwner = false;
    }
  }

  void buttonReportSaleClicked() {
    checkUserRole();
    if (isOwner) {
      Get.toNamed(Routes.REPORT_SALES, arguments: storeId);
    } else {
      Get.snackbar('Invalid', 'User didn\'t have permission');
    }
  }

  void buttonAddProductClicked() {
    checkUserRole();
    if (isOwner) {
      Get.toNamed(Routes.ADD_PRODUCT);
    } else {
      Get.snackbar('Invalid', 'User didn\'t have permission');
    }
  }
}
