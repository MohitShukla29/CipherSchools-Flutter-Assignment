import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cipherschool_expense_tracking_app/models/transaction_model.dart';

class IncomeProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _incomeCollection = FirebaseFirestore.instance.collection('income');

  String _selectedCategory = '';
  String _selectedWallet = '';
  String _description = '';
  double _totalIncome = 0.0;
  List<Transactions> _incomeTransactions = [];

  String get selectedCategory => _selectedCategory;
  String get selectedWallet => _selectedWallet;
  String get description => _description;
  double get totalIncome => _totalIncome;
  List<Transactions> get incomeTransactions => _incomeTransactions;

  IncomeProvider() {
    _loadIncomeTransactions();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setWallet(String wallet) {
    _selectedWallet = wallet;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  void addIncome(Transactions transaction) async {
    await _incomeCollection.add(transaction.toMap());
    _loadIncomeTransactions();
  }

  Future<void> _loadIncomeTransactions() async {
    final snapshot = await _incomeCollection.get();
    _incomeTransactions = snapshot.docs.map((doc) => Transactions.fromMap(doc.data() as Map<String, dynamic>)).toList();
    _totalIncome = _incomeTransactions.fold(0.0, (sum, transaction) => sum + transaction.amount);
    notifyListeners();
  }
}
