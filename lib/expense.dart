import 'package:flutter/material.dart';
import 'package:mma/chart/chart.dart';
import 'package:mma/chart/chart_bar.dart';
import 'package:mma/expense_list.dart';
import 'package:mma/models/expense_model.dart';
import 'package:mma/popup_modal.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final List<ExpenseM> _expenseList = [
    ExpenseM('Mumbai', 20.33, DateTime.now(), Category.travel),
    ExpenseM('Alfaam', 40.56, DateTime.now(), Category.food),
    ExpenseM('Adfxfgghfghfhf', 30.12, DateTime.now(), Category.movie),
    ExpenseM('College', 11.6, DateTime.now(), Category.work),
  ];

  void _addExpense(ExpenseM expense) {
    setState(() {
      _expenseList.add(expense);
    });
  }

  void _removeExpense(ExpenseM expense) {
    final index = _expenseList.indexOf(expense);
    setState(() {
      _expenseList.remove(expense);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 10),
          content: const Text('expense deleted'),
          action: SnackBarAction(
              label: 'undo',
              onPressed: () {
                setState(() {
                  _expenseList.insert(index, expense);
                });
              }),
        ),
      );
    });
  }

  void _openExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (cntxt) => PopupModal(_addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No expenses'),
    );

    if (_expenseList.isNotEmpty) {
      setState(() {
        mainContent = ExpenseList(_expenseList, _removeExpense);
      });
    }

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: _openExpenseOverlay, icon: const Icon(Icons.add))
      ]),
      body: Center(
        child: Column(
          children: [
            // ChartBar(fill: .5),
            Chart(expenses: _expenseList),
            
            mainContent,
          ],
        ),
      ),
    );
  }
}
