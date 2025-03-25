import 'package:cipherschool_expense_tracking_app/Screens/expense_screen.dart';
import 'package:cipherschool_expense_tracking_app/Screens/income_screen.dart';
import 'package:cipherschool_expense_tracking_app/controller/navigation_provider.dart';
import 'package:cipherschool_expense_tracking_app/controller/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedPeriod = 'Today';
  final List<String> _periods = ['Today', 'Week', 'Month', 'Year'];

  @override
  void initState() {
    super.initState();
    // Set status bar to be transparent with dark icons
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light, // For iOS
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light, // For iOS
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF8EA),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildAccountBalance(),
              _buildIncomeExpensesRow(),
              _buildTimePeriodSelector(),
              _buildTransactionList(),
              _buildBottomNavBar(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF7E3FF2),
          shape: CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('https://randomuser.me/api/portraits/women/44.jpg'),
            backgroundColor: Colors.purple.shade200,
          ),
          Row(
            children: [
              const Icon(Icons.keyboard_arrow_down, color: Color(0xFF7E3FF2)),
              const SizedBox(width: 4),
              const Text(
                'October',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.notifications_none, color: Color(0xFF7E3FF2)),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountBalance() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Consumer<TransactionProvider>(
        builder: (context, transactionProvider, child) {
          return Column(
            children: [
              const Text(
                'Account Balance',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '₹${transactionProvider.totalIncome - transactionProvider.totalExpenses}',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIncomeExpensesRow() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Consumer<TransactionProvider>(
            builder: (context, transactionProvider, child) {
              return Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1EB980),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.arrow_downward,
                              color: Color(0xFF1EB980),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              // Navigate to the income screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IncomeScreen(), // Replace with your actual income screen
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Income',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Consumer<TransactionProvider>(
                                  builder: (context, transactionProvider, child) {
                                    return Text(
                                      '₹${transactionProvider.totalIncome.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF44336),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.arrow_upward,
                              color: Color(0xFFF44336),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () {
                              // Navigate to the income screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExpenseScreen(), // Replace with your actual income screen
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Expenses',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Consumer<TransactionProvider>(
                                  builder: (context, transactionProvider, child) {
                                    return Text(
                                      '₹${transactionProvider.totalExpenses.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
      ),

    );
  }

  Widget _buildTimePeriodSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30.0),
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _periods.length,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemBuilder: (context, index) {
          final isSelected = _periods[index] == _selectedPeriod;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedPeriod = _periods[index];
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFFE5A8) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                _periods[index],
                style: TextStyle(
                  fontSize: 15,
                  color: isSelected ? Colors.orange : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

        Widget _buildTransactionList() {
      return Expanded(
        child: Consumer<TransactionProvider>(
          builder: (context, transactionProvider, child) {
            final recentTransactions = transactionProvider.transactions.take(4).toList();

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Transaction',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0DEFA),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF7E3FF2),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...recentTransactions.map((transaction) => _buildTransactionItem(
                    icon: _getIconForCategory(transaction.category),
                    iconColor: _getIconColorForCategory(transaction.category),
                    iconBgColor: _getIconBgColorForCategory(transaction.category),
                    title: transaction.category,
                    description: transaction.title,
                    amount: '${transaction.type == 'income' ? '+' : '-'} ₹${transaction.amount.toStringAsFixed(2)}',
                    time: transaction.date.toLocal().toString().substring(11, 16),
                  )).toList(),
                ],
              ),
            );
          },
        ),
      );
    }
    IconData _getIconForCategory(String category) {
      switch (category.toLowerCase()) {
        case 'salary':
          return Icons.attach_money;
        case 'freelance':
          return Icons.work;
        case 'investments':
          return Icons.trending_up;
        case 'shopping':
          return Icons.shopping_bag;
        case 'food':
          return Icons.fastfood;
        case 'travel':
          return Icons.directions_car;
        default:
          return Icons.category;
      }
    }

    Color _getIconColorForCategory(String category) {
      switch (category.toLowerCase()) {
        case 'salary':
          return Colors.green;
        case 'freelance':
          return Colors.blue;
        case 'investments':
          return Colors.purple;
        case 'shopping':
          return Colors.orange;
        case 'food':
          return Colors.red;
        case 'travel':
          return Colors.teal;
        default:
          return Colors.grey;
      }
    }

    Color _getIconBgColorForCategory(String category) {
      switch (category.toLowerCase()) {
        case 'salary':
          return Colors.green.shade100;
        case 'freelance':
          return Colors.blue.shade100;
        case 'investments':
          return Colors.purple.shade100;
        case 'shopping':
          return Colors.orange.shade100;
        case 'food':
          return Colors.red.shade100;
        case 'travel':
          return Colors.teal.shade100;
        default:
          return Colors.grey.shade100;
      }
    }

    Widget _buildTransactionItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String description,
    required String amount,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: 5,),
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Consumer<NavigationProvider>(
        builder: (context, navigationProvider, _) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: SafeArea(
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNavItem(
                      icon: Icons.home,
                      label: 'Home',
                      isSelected: navigationProvider.currentRoute == AppRoute.home,
                      route: AppRoute.home,
                    ),
                    _buildNavItem(
                      icon: Icons.sync_alt,
                      label: 'Transaction',
                      isSelected: navigationProvider.currentRoute == AppRoute.transaction,
                      route: AppRoute.transaction,
                    ),
                    const SizedBox(width: 24),
                    _buildNavItem(
                      icon: Icons.pie_chart,
                      label: 'Budget',
                      isSelected: navigationProvider.currentRoute == AppRoute.budget,
                      route: AppRoute.budget,
                    ),
                    _buildNavItem(
                      icon: Icons.person,
                      label: 'Profile',
                      isSelected: navigationProvider.currentRoute == AppRoute.profile,
                      route: AppRoute.profile,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required AppRoute route,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate using Provider
        Provider.of<NavigationProvider>(context, listen: false).navigateTo(route,context);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF7E3FF2) : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF7E3FF2) : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}