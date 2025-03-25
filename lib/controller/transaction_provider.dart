import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cipherschool_expense_tracking_app/models/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Transactions> _transactions = [];
  double _totalIncome = 0.0;
  double _totalExpenses = 0.0;

  List<Transactions> get transactions => _transactions;
  double get totalIncome => _totalIncome;
  double get totalExpenses => _totalExpenses;

  TransactionProvider() {
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    try {
      // Fetch income transactions
      final incomeSnapshot = await _firestore.collection('income').get();
      final incomeTransactions = incomeSnapshot.docs
          .map((doc) => Transactions.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      // Fetch expense transactions (you'll need to create a similar collection for expenses)
      final expenseSnapshot = await _firestore.collection('expenses').get();
      final expenseTransactions = expenseSnapshot.docs
          .map((doc) => Transactions.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      // Combine transactions
      _transactions = [...incomeTransactions, ...expenseTransactions]
        ..sort((a, b) => b.date.compareTo(a.date));

      // Calculate totals
      _totalIncome = incomeTransactions.fold(0.0, (sum, transaction) => sum + transaction.amount);
      _totalExpenses = expenseTransactions.fold(0.0, (sum, transaction) => sum + transaction.amount);

      notifyListeners();
    } catch (e) {
      print('Error loading transactions: $e');
    }
  }

  // Method to refresh transactions
  void refreshTransactions() {
    _loadTransactions();
  }
}