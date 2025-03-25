import 'package:cipherschool_expense_tracking_app/Screens/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cipherschool_expense_tracking_app/controller/expense_provider.dart';
import 'package:cipherschool_expense_tracking_app/models/transaction_model.dart';
import 'package:uuid/uuid.dart';

class ExpenseScreen extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: PopScope( // Use PopScope instead of WillPopScope
        canPop: false, // Prevent default pop
        onPopInvoked: (didPop) {
          if (didPop) return;
          // Safely navigate to home screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(context),
              SizedBox(height: 20),
              _buildTotalExpense(context),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildTextField('Amount', _amountController),
                      SizedBox(height: 15),
                      _buildDropdown('Category', context),
                      SizedBox(height: 15),
                      _buildTextField('Description', null),
                      SizedBox(height: 20),
                      _buildAddExpenseButton(context),
                      SizedBox(height: 20),
                      Expanded(child: _buildExpenseList(context)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // Use NavigationProvider to go back
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          Spacer(),
          Text(
            'Expense',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildTotalExpense(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<ExpenseProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Expense',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                '₹${provider.totalExpenses.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDropdown(String hintText, BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        List<String> options = ['Food', 'Transport', 'Shopping'];
        String? selectedValue = provider.selectedCategory;
        if (!options.contains(selectedValue)) {
          selectedValue = null;
        }

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text(hintText),
              value: selectedValue,
              isExpanded: true,
              items: options.map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
              onChanged: (value) {
                if (value != null) {
                  provider.setCategory(value);
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String hintText, TextEditingController? controller) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        return TextField(
          controller: controller,
          keyboardType: hintText == 'Amount' ? TextInputType.number : TextInputType.text,
          onChanged: (value) {
            if (hintText == 'Description') provider.setDescription(value);
          },
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddExpenseButton(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: Size(double.infinity, 50),
          ),
          onPressed: () {
            double amount = double.tryParse(_amountController.text) ?? 0.0;
            if (amount > 0 && provider.selectedCategory.isNotEmpty) {
              provider.addExpense(
                Transactions(
                  id: const Uuid().v4(),
                  title: provider.description,
                  amount: amount,
                  category: provider.selectedCategory,
                  date: DateTime.now(),
                  type: 'expense',
                ),
              );
              _amountController.clear();
            }
          },
          child: Text(
            'Add Expense',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        );
      },
    );
  }

  Widget _buildExpenseList(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, child) {
        if (provider.expenseTransactions.isEmpty) {
          return Center(child: Text("No Expense Transactions", style: TextStyle(color: Colors.grey)));
        }
        return ListView.builder(
          itemCount: provider.expenseTransactions.length,
          itemBuilder: (context, index) {
            final expense = provider.expenseTransactions[index];
            return ListTile(
              title: Text(expense.title),
              subtitle: Text('${expense.category} - ${expense.date.toLocal()}'),
              trailing: Text(
                '- ₹${expense.amount.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            );
          },
        );
      },
    );
  }
}