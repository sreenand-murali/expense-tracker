import 'package:flutter/material.dart';
import 'package:mma/models/expense_model.dart';

class PopupModal extends StatefulWidget {
  const PopupModal(this.addExpenses, {super.key});

  final void Function(ExpenseM) addExpenses;

  @override
  State<PopupModal> createState() => _PopupModalState();
}

class _PopupModalState extends State<PopupModal> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? pickedDate;
  Category _selectedCategory = Category.travel;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Enter Expenses'),
          const SizedBox(
            height: 16,
          ),
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Enter Title...'),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text('Enter Amount'),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(pickedDate == null
                        ? 'select date'
                        : formatter.format(pickedDate!)),
                    IconButton(
                        onPressed: () async {
                          final DateTime now = DateTime.now();
                          final DateTime firstDate =
                              DateTime(now.year - 1, now.month, now.day);
                          final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: now,
                              firstDate: firstDate,
                              lastDate: now);
                          setState(() {
                            pickedDate = selectedDate;
                          });
                        },
                        icon: const Icon(Icons.date_range_outlined)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(children: [
            DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value == null) return;
                    _selectedCategory = value;
                  });
                }),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('cancel'),
            ),
            const SizedBox(
              width: 6,
            ),
            ElevatedButton(
              onPressed: () {
                final double? enteredAmount =
                    double.tryParse(_amountController.text);
                if (_titleController.text.trim().isEmpty ||
                    enteredAmount == null ||
                    enteredAmount < 0 ||
                    pickedDate == null) {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Missing Entry"),
                      content: const Text(
                          "Title is Empty or Amount is not set properly or date is not set"),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                          child: const Text('yep'),
                        ),
                      ],
                    ),
                  );
                  return;
                }
                widget.addExpenses(ExpenseM(_titleController.text, enteredAmount,
                    pickedDate!, _selectedCategory));
                Navigator.pop(context);
              },
              child: const Text("save expense"),
            ),
          ]),
        ],
      ),
    );
  }
}
