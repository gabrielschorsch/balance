import 'package:app/domains/expense.dart';

abstract class IExpenseRepository  {
  Future<List<Expense>> getExpenses();
  Future<Expense> getExpense(int id);
  Future<int> insertExpense(Expense expense);
  Future<int> updateExpense(Expense expense);
  Future<int> deleteExpense(int id);
}