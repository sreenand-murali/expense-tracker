import 'package:flutter/material.dart';
import 'package:mma/models/expense_model.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.details, {super.key});
  final ExpenseM details;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text(details.title),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('\$${details.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[details.category]),
                    const SizedBox(width: 5,),
                    Text(details.formatedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
