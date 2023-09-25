import 'package:app/domains/expense.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  final Color color;
  final Expense expense;

  const ExpenseCard({super.key, required this.color, required this.expense});

  String get timeSinceExpense {
    final now = DateTime.now();
    final expenseDate = expense.date!;
    final difference = now.difference(expenseDate);
    if (difference.inDays == 0) {
      return "<1d";
    } else if (difference.inDays == 1) {
      return "1d";
    } else {
      return "${difference.inDays}d";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: color,
          ),
          width: MediaQuery.of(context).size.width * .95,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    timeSinceExpense,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[50],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Text(
                        expense.name ?? "",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[50],
                        ),
                      ),
                      Text(
                        "R\$${((expense.value ?? -1) != -1 ? expense.value! : expense.budget!).toStringAsFixed(2).replaceAll(".", ",")}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[50],
                        ),
                      ),
                    ],
                  ),
                ),
                // Expanded(
                //   flex: 1,
                //   child: IconButton(
                //     onPressed: () {},
                //     icon: Icon(
                //       Icons.edit,
                //       color: Colors.grey[50],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        )
      ],
    );
  }
}
