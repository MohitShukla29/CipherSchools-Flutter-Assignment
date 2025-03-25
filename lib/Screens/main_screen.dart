import 'package:cipherschool_expense_tracking_app/Screens/Home.dart';
import 'package:cipherschool_expense_tracking_app/Screens/expense_screen.dart';
import 'package:cipherschool_expense_tracking_app/Screens/income_screen.dart';
import 'package:cipherschool_expense_tracking_app/Screens/profile_screen.dart';
import 'package:cipherschool_expense_tracking_app/controller/navigation_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    // Return the appropriate screen based on current route
    switch (navigationProvider.currentRoute) {
      case AppRoute.home:
        return const HomeScreen();
      case AppRoute.transaction:
        return ExpenseScreen();
      case AppRoute.budget:
        return  IncomeScreen();
      case AppRoute.profile:
        return ProfilePage();
    }
  }
}

