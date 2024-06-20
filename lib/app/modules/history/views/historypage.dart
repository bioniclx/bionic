import 'package:bionic/app/models/purchase_history.dart';
import 'package:bionic/app/modules/history/controller/historycontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  final HistoryController historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
        ),
      ),
      body: Obx(() {
        var groupedTransactions =
            groupTransactionsByDate(historyController.transactions);
        return ListView.builder(
          itemCount: groupedTransactions.length,
          itemBuilder: (context, index) {
            var date = groupedTransactions.keys.toList()[index];
            var transactions = groupedTransactions[date]!;
            return buildTransactionGroup(date, transactions);
          },
        );
      }),
    );
  }

  Widget buildTransactionGroup(DateTime date, List<Transaction> transactions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            DateFormat('dd MMMM yyyy', 'id_ID').format(date),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...transactions
            .map((transaction) => buildTransactionItem(transaction))
            .toList(),
      ],
    );
  }

  Widget buildTransactionItem(Transaction transaction) {
    return ListTile(
      leading: Container(
        width: 5,
        height: double.infinity,
        color: Colors.blue,
      ),
      title: Text(transaction.namaPembeli),
      subtitle:
          Text(DateFormat('dd MMMM yyyy', 'id_ID').format(transaction.date)),
      trailing: Text(
        'Rp ${transaction.amount}',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Map<DateTime, List<Transaction>> groupTransactionsByDate(
      List<Transaction> transactions) {
    var map = <DateTime, List<Transaction>>{};
    for (var transaction in transactions) {
      var date = DateTime(
          transaction.date.year, transaction.date.month, transaction.date.day);
      if (!map.containsKey(date)) {
        map[date] = [];
      }
      map[date]!.add(transaction);
    }
    return map;
  }
}
