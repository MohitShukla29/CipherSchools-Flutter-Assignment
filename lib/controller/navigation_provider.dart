import 'package:cipherschool_expense_tracking_app/Screens/Home.dart';
import 'package:cipherschool_expense_tracking_app/Screens/expense_screen.dart';
import 'package:flutter/material.dart';

import 'package:cipherschool_expense_tracking_app/Screens/transaction_screen.dart';

import 'package:cipherschool_expense_tracking_app/Screens/profile_screen.dart';

enum AppRoute {
  home,
  transaction,
  budget,
  profile,
}

class NavigationProvider extends ChangeNotifier {
  AppRoute _currentRoute = AppRoute.home;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  AppRoute get currentRoute => _currentRoute;

  void navigateTo(AppRoute route, BuildContext context) {
    if (_currentRoute != route) {
      _currentRoute = route;

      // Map routes to their corresponding screens
      Widget targetScreen;
      switch (route) {
        case AppRoute.home:
          targetScreen = HomeScreen();
          break;
        case AppRoute.transaction:
          targetScreen = AllTransactionsScreen();
          break;
        case AppRoute.budget:
          targetScreen = ExpenseScreen();
          break;
        case AppRoute.profile:
          targetScreen = ProfilePage();
          break;
      }

      // Use push replacement to avoid stacking multiple instances of the same screen
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => targetScreen)
      );

      notifyListeners();
    }
  }

  void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}