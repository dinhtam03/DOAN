import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'auth_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Expense> _expenses = [];

  void _addExpense() {
    String title = '';
    double amount = 0;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Thêm chi tiêu'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Tên chi tiêu'),
              onChanged: (val) => title = val,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Số tiền'),
              keyboardType: TextInputType.number,
              onChanged: (val) => amount = double.tryParse(val) ?? 0,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (title.isNotEmpty && amount > 0) {
                setState(() {
                  _expenses.add(Expense(
                    id: DateTime.now().toString(),
                    title: title,
                    amount: amount,
                    date: DateTime.now(),
                  ));
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void _deleteExpense(String id) {
    setState(() => _expenses.removeWhere((e) => e.id == id));
  }

  @override
  Widget build(BuildContext context) {
    double total = _expenses.fold(0, (sum, e) => sum + e.amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý chi tiêu cá nhân'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.teal[100],
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Text(
              'Tổng chi tiêu: ${total.toStringAsFixed(0)} VNĐ',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (ctx, i) {
                final e = _expenses[i];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    title: Text(e.title),
                    subtitle: Text(
                        '${e.amount.toStringAsFixed(0)} VNĐ - ${e.date.day}/${e.date.month}/${e.date.year}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteExpense(e.id),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExpense,
        child: const Icon(Icons.add),
      ),
    );
  }
}
