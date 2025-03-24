import 'package:cloud_firestore/cloud_firestore.dart';

class Transactions {
  final String id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final String type;

  Transactions({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.type,
  });

  factory Transactions.fromMap(Map<String, dynamic> map) {
    return Transactions(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      category: map['category'],
      date: (map['date'] as Timestamp).toDate(),
      type: map['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'date': Timestamp.fromDate(date),
      'type': type,
    };
  }
}
