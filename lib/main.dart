import 'package:cipherschool_expense_tracking_app/Screens/Home.dart';
import 'package:cipherschool_expense_tracking_app/Screens/profile_screen.dart';
import 'package:cipherschool_expense_tracking_app/Screens/splash_screen.dart';
import 'package:cipherschool_expense_tracking_app/controller/expense_provider.dart';
import 'package:cipherschool_expense_tracking_app/controller/expense_provider.dart';
import 'package:cipherschool_expense_tracking_app/controller/home_provider.dart';
import 'package:cipherschool_expense_tracking_app/controller/income_provider.dart';
import 'package:cipherschool_expense_tracking_app/controller/signup_provider.dart';
import 'package:cipherschool_expense_tracking_app/firebase_options.dart';
import 'package:cipherschool_expense_tracking_app/getting_started.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cipherschool_expense_tracking_app/Screens/signup_page.dart';
import 'package:cipherschool_expense_tracking_app/Screens/expense_screen.dart';
import 'package:cipherschool_expense_tracking_app/Screens/income_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
      runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => IncomeProvider()),
      ChangeNotifierProvider(create: (context) => ExpenseProvider()),
      ChangeNotifierProvider(create: (context) => SignUpProvider()),
      ChangeNotifierProvider(create: (context) => HomeProvider()),
    ],
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
        home: ExpenseScreen()
    );
  }
}

