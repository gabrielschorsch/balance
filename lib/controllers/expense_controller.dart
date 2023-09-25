import 'package:app/domains/category.dart';
import 'package:app/domains/expense.dart';
import 'package:app/repository/expense_repository.dart';
import 'package:flutter/material.dart';

class ExpenseController extends ChangeNotifier {
  final repository = ExpenseRepository();

  Future<List<Expense>> getExpenses() async {
    return await repository.getExpenses();
  }

  Future<List<Expense>> getFilteredExpenses(
      {int? month, Category? category}) async {
    List<Expense> fullList = await repository.getExpenses();

    if (category != null) {
      fullList =
          fullList.where((element) => element.category == category).toList();
    }
    if (month != null) {
      fullList =
          fullList.where((element) => element.date!.month == month).toList();
    }
    notifyListeners();
    return fullList;
  }

  Future<void> addExpense(Expense expense) async {
    await repository.insertExpense(expense);
    notifyListeners();
  }

  Future<void> updateExpense(Expense expense) async {
    await repository.updateExpense(expense);
    notifyListeners();
  }

  Future<void> deleteExpense(int id) async {
    await repository.deleteExpense(id);
    notifyListeners();
  }
}
