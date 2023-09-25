import 'package:app/components/expense_card.dart';
import 'package:app/controllers/category_controller.dart';
import 'package:app/controllers/expense_controller.dart';
import 'package:app/domains/category.dart';
import 'package:app/domains/expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<String> months = [
    "Jan",
    "Fev",
    "Mar",
    "Abr",
    "Mai",
    "Jun",
    "Jul",
    "Ago",
    "Set",
    "Out",
    "Nov",
    "Dez",
  ];
  String? get currentMonth {
    return months[DateTime.now().month - 1];
  }

  int selectedMonth = DateTime.now().month - 1;
  final ScrollController _controller = ScrollController();
  Category? filter;
  List<Expense> expenses = [];
  List<Expense> fullList = [];

  @override
  void initState() {
    (Provider.of<ExpenseController>(context, listen: false).getExpenses())
        .then((value) {
      fullList = value.toList();
    });

    super.initState();
    expenses = fullList
        .where((element) => element.date!.month == selectedMonth + 1)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    _controller.animateTo(selectedMonth * 80.0 - 160,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);

    buildHistory(BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width * .8,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 20,
                right: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Histórico",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  filter != null
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              filter = null;

                              expenses = fullList
                                  .where((element) =>
                                      element.date!.month == selectedMonth + 1)
                                  .toList();
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : Container(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 20,
              ),
              child: Consumer<ExpenseController>(
                builder: (context, expenseController, child) => FutureBuilder(
                    future: expenseController.getExpenses(),
                    builder: (context, expenseSnapshot) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: expenses.length,
                          itemBuilder: (_, index) => ExpenseCard(
                                color: Color(int.parse(
                                    "0xFF${expenses[index].category!.color!.replaceAll('#', '')}")),
                                name: expenses[index].name!,
                                value: expenses[index].value!.toString(),
                              ));
                    }),
              ),
            )
          ],
        ),
      );
    }

    buildChart(BuildContext context, List<Category> categories) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * .8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: Consumer<ExpenseController>(
                  builder: (context, expenseController, child) => FutureBuilder(
                    future: expenseController.getExpenses(),
                    builder: (context, expenseSnapshot) {
                      return PieChart(
                        PieChartData(
                          sections: expenses
                              .map(
                                (expense) => PieChartSectionData(
                                  color: Color(int.parse(
                                      "0xFF${expense.category!.color!.replaceAll('#', '')}")),
                                  value: expense.value!.toDouble(),
                                  showTitle: false,
                                  // title: expense.category!.name!,
                                  radius: 50,
                                ),
                              )
                              .toList(),
                          pieTouchData: PieTouchData(
                            enabled: true,
                            touchCallback: (p0, p1) {
                              var originalList = expenseSnapshot.data!;
                              var selectedElement = originalList[
                                  p1!.touchedSection!.touchedSectionIndex];
                              setState(() {
                                filter = selectedElement.category;

                                expenses = expenses
                                    .where(
                                      (element) =>
                                          element.category!.id ==
                                          selectedElement.category!.id,
                                    )
                                    .toList();
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          leading: _getMonthsList(),
          leadingWidth: MediaQuery.of(context).size.width,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(slivers: [
            SliverList(
              delegate: SliverChildListDelegate([
                Consumer<CategoryController>(
                  builder: (context, categoryController, child) =>
                      FutureBuilder(
                    future: categoryController.getCategories(),
                    builder: (context, snapshot) {
                      return buildChart(context, snapshot.data ?? []);
                    },
                  ),
                ),
                buildHistory(context),
              ]),
            ),
          ]),
        ));
  }

  _getMonthsList() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ListView.builder(
        controller: _controller,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedMonth = index;

                expenses = fullList
                    .where(
                        (element) => element.date!.month == selectedMonth + 1)
                    .toList();
              });
            },
            child: Container(
              width: 80,
              height: 50,
              decoration: BoxDecoration(
                color: selectedMonth == index
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
              ),
              child: Center(
                child: Text(
                  months[index],
                  style: TextStyle(
                    color: selectedMonth == index
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: 12,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
