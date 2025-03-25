import 'package:cipherschool_expense_tracking_app/Screens/Home.dart';
import 'package:cipherschool_expense_tracking_app/Screens/profile_screen.dart';
import 'package:cipherschool_expense_tracking_app/Screens/splash_screen.dart';
import 'package:cipherschool_expense_tracking_app/Screens/transaction_screen.dart';
import 'package:cipherschool_expense_tracking_app/controller/bottom_nav_bar.dart';
import 'package:cipherschool_expense_tracking_app/controller/expense_provider.dart';
import 'package:cipherschool_expense_tracking_app/controller/home_provider.dart';
import 'package:cipherschool_expense_tracking_app/controller/income_provider.dart';
import 'package:cipherschool_expense_tracking_app/controller/signup_provider.dart';
import 'package:cipherschool_expense_tracking_app/controller/navigation_provider.dart'; // ✅ Import NavigationProvider
import 'package:cipherschool_expense_tracking_app/controller/transaction_provider.dart';
import 'package:cipherschool_expense_tracking_app/firebase_options.dart';
import 'package:cipherschool_expense_tracking_app/getting_started.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cipherschool_expense_tracking_app/Screens/signup_page.dart';
import 'package:cipherschool_expense_tracking_app/Screens/expense_screen.dart';
import 'package:cipherschool_expense_tracking_app/Screens/income_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IncomeProvider()),
        ChangeNotifierProvider(create: (context) => ExpenseProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If still checking authentication
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        }

        // If no user is logged in
        if (!snapshot.hasData) {
          return Getting_started();
        }

        // If user is logged in, use NavigationProvider for routing
        return Consumer<NavigationProvider>(
          builder: (context, navigationProvider, child) {
            // Use the current route to determine which screen to show
            switch (navigationProvider.currentRoute) {
              case AppRoute.home:
                return HomeScreen();
              case AppRoute.transaction:
                return AllTransactionsScreen();
              case AppRoute.budget:
                return ExpenseScreen();
              case AppRoute.profile:
                return ProfilePage();
              default:
                return HomeScreen();
            }
          },
        );
      },
    );
  }
}
