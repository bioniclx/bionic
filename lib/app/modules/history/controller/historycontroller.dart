import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart'
    as firestore;
import 'package:get/get.dart';

import 'package:bionic/app/models/purchase_history.dart';

class HistoryController extends GetxController {
  // Use Rx to manage reactive transactions list
  final RxList<Transaction> transactions = RxList<Transaction>([]);

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    try {
      final snapshot = await firestore.FirebaseFirestore.instance
          .collection('pembelian')
          .orderBy('date', descending: true)
          .get();

      transactions.value = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        final transactionId = doc.id;
        final amount = data['amount'];
        final date = (data['date'] as firestore.Timestamp).toDate();
        final buyerName = data['namaPembeli'] as String;

        return Transaction(
          id: transactionId,
          amount: amount,
          date: date,
          namaPembeli: buyerName, // or 'histori' if that's the preferred name
        );
      }).toList();
    } catch (error) {
      // Handle errors appropriately (e.g., display an error message)
      Get.snackbar('Error', 'Error fetching transactions: $error');
    }
  }
}
