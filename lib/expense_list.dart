import 'package:flutter/material.dart';
import 'package:mma/models/expense_item.dart';
import 'package:mma/models/expense_model.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(this.expenses, this.removeExpense, {super.key});

  final List<ExpenseM> expenses;
  final Function(ExpenseM expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
            key: ValueKey(expenses[index]),
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(.50),
              margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal,
              ),
            ),
            onDismissed: (direction) {
              removeExpense(expenses[index]);
            },
            child: ExpenseItem(expenses[index])),
      ),
    );
  }
}
