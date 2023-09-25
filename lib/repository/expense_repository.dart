import 'package:app/domains/category.dart';
import 'package:app/domains/expense.dart';
import 'package:app/repository/expense_interface.dart';

class ExpenseRepository implements IExpenseRepository {
  static List<Expense> expenses = [
    Expense(
      id: "1",
      category: Category(
        id: "1",
        name: "Alimentação",
        color: "#E57373",
      ),
      name: "Almoço",
      value: 20,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Expense(
      id: "2",
      category: Category(
        id: "1",
        name: "Alimentação",
        color: "#E57373",
      ),
      name: "Janta",
      value: 20,
      date: DateTime.now().subtract(const Duration(days: 60)),
    ),
    Expense(
      id: "3",
      category: Category(
        id: "2",
        name: "Transporte",
        color: "#BA68C8",
      ),
      name: "Uber",
      value: 10,
      budget: 20,
      date: DateTime.now(),
    ),
    Expense(
      id: "4",
      category: Category(
        id: "2",
        name: "Transporte",
        color: "#BA68C8",
      ),
      name: "Ônibus",
      value: 5,
      budget: 20,
      date: DateTime.now().subtract(const Duration(days: 30)),
    ),
    Expense(
      id: "5",
      category: Category(
        id: "2",
        name: "Transporte",
        color: "#BA68C8",
      ),
      name: "Cinema",
      value: 35,
      budget: 50,
      date: DateTime.now(),
    ),
  ];

  @override
  Future<int> deleteExpense(int id) {
    expenses.removeWhere((element) => element.id == id.toString());
    return Future.value(1);
  }

  @override
  Future<Expense> getExpense(int id) {
    return Future.value(
        expenses.firstWhere((element) => element.id == id.toString()));
  }

  @override
  Future<List<Expense>> getExpenses() {
    return Future.value(expenses);
  }

  @override
  Future<int> insertExpense(Expense expense) {
    expenses.add(expense);
    return Future.value(1);
  }

  @override
  Future<int> updateExpense(Expense expense) {
    expenses.removeWhere((element) => element.id == expense.id);
    expenses.add(expense);
    return Future.value(1);
  }
}
