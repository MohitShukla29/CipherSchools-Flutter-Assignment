import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cipherschool_expense_tracking_app/controller/income_provider.dart';
import 'package:cipherschool_expense_tracking_app/models/transaction_model.dart';

class IncomeScreen extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            SizedBox(height: 20),
            _buildTotalIncome(context),
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
                    _buildAddIncomeButton(context),
                    SizedBox(height: 20),
                    Expanded(child: _buildIncomeList(context)), // Display List
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// App Bar with Back Button
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          Spacer(),
          Text(
            'Income',
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

  /// Display Total Income
  Widget _buildTotalIncome(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<IncomeProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Income',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                '₹${provider.totalIncome.toStringAsFixed(2)}',
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

  /// Dropdown for Category & Wallet
  Widget _buildDropdown(String hintText, BuildContext context) {
    return Consumer<IncomeProvider>(
      builder: (context, provider, child) {
        List<String> options = ['Salary', 'Freelance', 'Investments'];

        String? selectedValue = (hintText == 'Category' ? provider.selectedCategory : provider.selectedWallet);
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
                  if (hintText == 'Category') {
                    provider.setCategory(value);
                  } else {
                    provider.setWallet(value);
                  }
                }
              },
            ),
          ),
        );
      },
    );
  }

  /// Text Field for Amount & Description
  Widget _buildTextField(String hintText, TextEditingController? controller) {
    return Consumer<IncomeProvider>(
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

  /// Add Income Button
  Widget _buildAddIncomeButton(BuildContext context) {
    return Consumer<IncomeProvider>(
      builder: (context, provider, child) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: Size(double.infinity, 50),
          ),
          onPressed: () {
            double amount = double.tryParse(_amountController.text) ?? 0.0;
            if (amount > 0 && provider.selectedCategory.isNotEmpty) {
              provider.addIncome(
                Transactions(
                  id: DateTime.now().toString(),
                  title: provider.description,
                  amount: amount,
                  category: provider.selectedCategory,
                  date: DateTime.now(),
                  type: 'income',
                ),
              );
              _amountController.clear();
            }
          },
          child: Text(
            'Add Income',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        );
      },
    );
  }

  /// List of Income Transactions
  Widget _buildIncomeList(BuildContext context) {
    return Consumer<IncomeProvider>(
      builder: (context, provider, child) {
        if (provider.incomeTransactions.isEmpty) {
          return Center(child: Text("No Income Transactions", style: TextStyle(color: Colors.grey)));
        }
        return ListView.builder(
          itemCount: provider.incomeTransactions.length,
          itemBuilder: (context, index) {
            final income = provider.incomeTransactions[index];
            return ListTile(
              title: Text(income.title),
              subtitle: Text('${income.category} - ${income.date.toLocal()}'),
              trailing: Text(
                '+ ₹${income.amount.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
            );
          },
        );
      },
    );
  }
}

