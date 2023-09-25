import 'package:app/domains/expense.dart';
import 'package:app/repository/expense_repository.dart';
import 'package:flutter/material.dart';

class ExpenseController extends ChangeNotifier {
  final repository = ExpenseRepository();

  Future<List<Expense>> getExpenses() async {
    return await repository.getExpenses();
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
