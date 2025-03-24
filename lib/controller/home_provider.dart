import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  String _selectedPeriod = 'Today';
  final List<String> _periods = ['Today', 'Week', 'Month', 'Year'];

  String get selectedPeriod => _selectedPeriod;
  List<String> get periods => _periods;

  void updateSelectedPeriod(String period) {
    _selectedPeriod = period;
    notifyListeners();
  }
}
