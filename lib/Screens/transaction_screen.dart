import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cipherschool_expense_tracking_app/controller/transaction_provider.dart';
import 'package:cipherschool_expense_tracking_app/models/transaction_model.dart';

class AllTransactionsScreen extends StatefulWidget {
  const AllTransactionsScreen({Key? key}) : super(key: key);

  @override
  _AllTransactionsScreenState createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
  String _selectedFilter = 'All';
  bool _isAscending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Transactions'),
        backgroundColor: Color(0xFF7E3FF2),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterBottomSheet,
          ),
          IconButton(
            icon: Icon(_isAscending ? Icons.arrow_downward : Icons.arrow_upward),
            onPressed: () {
              setState(() {
                _isAscending = !_isAscending;
              });
            },
          ),
        ],
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, transactionProvider, child) {
          // Apply filtering
          List<Transactions> filteredTransactions = transactionProvider.transactions;

          if (_selectedFilter != 'All') {
            filteredTransactions = filteredTransactions
                .where((transaction) => transaction.type == _selectedFilter.toLowerCase())
                .toList();
          }

          // Apply sorting
          filteredTransactions.sort((a, b) {
            return _isAscending
                ? a.date.compareTo(b.date)
                : b.date.compareTo(a.date);
          });

          // Group transactions by date
          Map<String, List<Transactions>> groupedTransactions = {};
          for (var transaction in filteredTransactions) {
            String dateKey = DateFormat('yyyy-MM-dd').format(transaction.date);
            if (!groupedTransactions.containsKey(dateKey)) {
              groupedTransactions[dateKey] = [];
            }
            groupedTransactions[dateKey]!.add(transaction);
          }

          return ListView(
            children: groupedTransactions.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _formatDateHeader(entry.key),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  ...entry.value.map((transaction) => _buildTransactionItem(transaction)).toList(),
                ],
              );
            }).toList(),
          );
        },
      ),
      bottomNavigationBar: _buildSummaryBar(),
    );
  }

  Widget _buildTransactionItem(Transactions transaction) {
    return ListTile(
      leading: _buildTransactionIcon(transaction),
      title: Text(
        transaction.category,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(transaction.title),
      trailing: Text(
        '${transaction.type == 'income' ? '+' : '-'} ₹${transaction.amount.toStringAsFixed(2)}',
        style: TextStyle(
          color: transaction.type == 'income' ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTransactionIcon(Transactions transaction) {
    IconData icon;
    Color iconColor;
    Color bgColor;

    switch (transaction.category.toLowerCase()) {
      case 'salary':
        icon = Icons.attach_money;
        iconColor = Colors.green;
        bgColor = Colors.green.shade100;
        break;
      case 'freelance':
        icon = Icons.work;
        iconColor = Colors.blue;
        bgColor = Colors.blue.shade100;
        break;
      case 'shopping':
        icon = Icons.shopping_bag;
        iconColor = Colors.orange;
        bgColor = Colors.orange.shade100;
        break;
      case 'food':
        icon = Icons.fastfood;
        iconColor = Colors.red;
        bgColor = Colors.red.shade100;
        break;
      case 'travel':
        icon = Icons.directions_car;
        iconColor = Colors.teal;
        bgColor = Colors.teal.shade100;
        break;
      default:
        icon = Icons.category;
        iconColor = Colors.grey;
        bgColor = Colors.grey.shade100;
    }

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: iconColor),
    );
  }

  Widget _buildSummaryBar() {
    return Consumer<TransactionProvider>(
      builder: (context, transactionProvider, child) {
        return Container(
          padding: EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryItem(
                  'Income',
                  '₹${transactionProvider.totalIncome.toStringAsFixed(2)}',
                  Colors.green
              ),
              _buildSummaryItem(
                  'Expenses',
                  '₹${transactionProvider.totalExpenses.toStringAsFixed(2)}',
                  Colors.red
              ),
              _buildSummaryItem(
                  'Balance',
                  '₹${(transactionProvider.totalIncome - transactionProvider.totalExpenses).toStringAsFixed(2)}',
                  Colors.purple
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryItem(String label, String amount, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey),
        ),
        Text(
          amount,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('All Transactions'),
              onTap: () {
                setState(() {
                  _selectedFilter = 'All';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Income'),
              onTap: () {
                setState(() {
                  _selectedFilter = 'Income';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Expenses'),
              onTap: () {
                setState(() {
                  _selectedFilter = 'Expenses';
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  String _formatDateHeader(String dateKey) {
    DateTime date = DateTime.parse(dateKey);
    return DateFormat('EEEE, MMMM d, yyyy').format(date);
  }
}