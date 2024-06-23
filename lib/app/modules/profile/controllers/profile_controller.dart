import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileController extends GetxController {
  var name = ''.obs;
  var role = ''.obs;
  var imageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  void fetchProfileData() async {
    // Assuming a collection 'users' and a document with ID 'profileID'
    var doc =
        await FirebaseFirestore.instance.collection('user').doc('uid').get();
    if (doc.exists) {
      name.value = doc.data()?['fullname'];
      role.value = doc.data()?['role'];
      imageUrl.value = doc.data()?['imageUrl'];
    }
  }
}
