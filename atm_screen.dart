import 'package:flutter/material.dart';

class AtmScreen extends StatefulWidget {
  const AtmScreen({super.key});

  @override
  _AtmScreenState createState() => _AtmScreenState();
}

class _AtmScreenState extends State<AtmScreen> {
  double _balance = 1000.0; // Default balance
  final TextEditingController _amountController = TextEditingController();

  void _checkBalance() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Balance Inquiry"),
          content:
              Text("Your current balance is RS${_balance.toStringAsFixed(2)}."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _depositMoney() {
    double? amount = double.tryParse(_amountController.text);
    if (amount != null && amount > 0) {
      setState(() {
        _balance += amount;
      });
      _showMessage("Successfully deposited \$${amount.toStringAsFixed(2)}.");
    } else {
      _showMessage("Please enter a valid amount.");
    }
  }

  void _withdrawMoney() {
    double? amount = double.tryParse(_amountController.text);
    if (amount != null && amount > 0) {
      if (amount <= _balance) {
        setState(() {
          _balance -= amount;
        });
        _showMessage("Successfully withdrew \$${amount.toStringAsFixed(2)}.");
      } else {
        _showMessage("Insufficient balance!");
      }
    } else {
      _showMessage("Please enter a valid amount.");
    }
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Transaction"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
    _amountController.clear();
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ATM Machine",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Amount",
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton("Check Balance", _checkBalance),
                _buildButton("Deposit", _depositMoney),
                _buildButton("Withdraw", _withdrawMoney),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
