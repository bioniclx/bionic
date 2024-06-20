import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class Transaction {
  final String id;
  final String namaPembeli;
  final int amount; // Menggunakan tipe int
  final DateTime date;

  Transaction({
    required this.id,
    required this.namaPembeli,
    required this.amount,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      namaPembeli: json['histori'] as String ?? 'Unknown',
      amount: json['amount'] as int ?? 0,
      date: (json['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'namaPembeli': namaPembeli,
        'amount': amount,
        'date': Timestamp.fromDate(date),
      };
}
