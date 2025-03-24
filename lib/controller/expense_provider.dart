// controller/expense_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:cipherschool_expense_tracking_app/models/transaction_model.dart';

class ExpenseProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _expenseCollection = FirebaseFirestore.instance.collection('expenses');

  String _selectedCategory = '';
  String _description = '';
  double _totalExpenses = 0.0;
  List<Transactions> _expenseTransactions = [];

  String get selectedCategory => _selectedCategory;
  String get description => _description;
  double get totalExpenses => _totalExpenses;
  List<Transactions> get expenseTransactions => _expenseTransactions;

  ExpenseProvider() {
    _loadExpenseTransactions();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  void addExpense(Transactions transaction) async {
    await _expenseCollection.add(transaction.toMap());
    _loadExpenseTransactions();
  }

  Future<void> _loadExpenseTransactions() async {
    final snapshot = await _expenseCollection.get();
    _expenseTransactions = snapshot.docs.map((doc) => Transactions.fromMap(doc.data() as Map<String, dynamic>)).toList();
    _totalExpenses = _expenseTransactions.fold(0.0, (sum, transaction) => sum + transaction.amount);
    notifyListeners();
  }
}