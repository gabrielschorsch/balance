import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  final Color color;
  final String name;
  final String value;

  const ExpenseCard({
    super.key,
    required this.color,
    required this.name,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            clipBehavior: Clip.antiAlias,
            height: 50,
            width: MediaQuery.of(context).size.width * .8,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(color: color),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Text(
                        name,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                          "R\$${double.parse(value).toStringAsFixed(2).replaceAll(".", ",")}"),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
