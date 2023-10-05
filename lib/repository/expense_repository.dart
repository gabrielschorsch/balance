import 'package:app/domains/expense.dart';
import 'package:app/repository/expense_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpenseRepository implements IExpenseRepository {
  static var db = FirebaseFirestore.instance;

  static const collection = "expenses";

  @override
  Future<int> deleteExpense(int id) async {
    await db.collection(collection).doc("").delete();
    return Future.value(1);
  }

  @override
  Future<Expense> getExpense(int id) {
    return Future.value(Expense());
  }

  @override
  Future<List<Expense>> getExpenses() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    return await db
        .collection(collection)
        .where("userId", isEqualTo: userId)
        .get()
        .then((value) {
      return value.docs.map((e) => Expense.fromMap(e.data())).toList();
    });
  }

  @override
  Future<int> insertExpense(Expense expense) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var post = expense.toMap();
    post.addEntries(
      [
        MapEntry("userId", userId),
      ],
    );
    await db.collection(collection).add(post);
    return Future.value(1);
  }

  @override
  Future<int> updateExpense(Expense expense) {
    return Future.value(1);
  }
}
