import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

enum Category { movie, travel, food, work,study, entertainment }

const categoryIcons = {
  Category.food: Icons.fastfood_outlined,
  Category.movie: Icons.movie_filter_outlined,
  Category.travel: Icons.mode_of_travel_outlined,
  Category.work: Icons.work_outline_outlined,
  Category.study: Icons.system_security_update_good,
  Category.entertainment: Icons.event_seat_outlined,
};

const uuid = Uuid();
final formatter = DateFormat.yMd();

class ExpenseM {
  ExpenseM(this.title, this.amount, this.date, this.category) : id = uuid.v4();

  String id;
  String title;
  double amount;
  DateTime date;
  Category category;

  String get formatedDate {
    return formatter.format(date);
  }
}

class ExpenseCalculate {
  ExpenseCalculate(this.expenseList, this.category);
  ExpenseCalculate.perCat(List<ExpenseM> allExpenseList, this.category)
      : expenseList = allExpenseList
            .where((element) => element.category == category)
            .toList();
  final List<ExpenseM> expenseList;
  final Category category;

  double sum = 0;
  double get totalExpense {
    for (ExpenseM exp in expenseList) {
      sum += exp.amount;
    }
    return sum;
  }
}
