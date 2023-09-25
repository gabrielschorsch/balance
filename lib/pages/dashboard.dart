import 'package:app/components/expense_card.dart';
import 'package:app/controllers/expense_controller.dart';
import 'package:app/domains/category.dart';
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

  late int selectedMonth;
  final ScrollController _controller = ScrollController();
  Category? filter;

  @override
  void initState() {
    selectedMonth = DateTime.now().month - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller.animateTo(selectedMonth * 80.0 - 160,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);

    buildHistory(BuildContext context, ExpenseController expenseController) {
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
              child: FutureBuilder(
                future: expenseController.getFilteredExpenses(
                    month: selectedMonth + 1, category: filter),
                builder: (context, expenseSnapshot) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: (expenseSnapshot.data ?? []).length,
                      itemBuilder: (_, index) => ExpenseCard(
                            color: Color(int.parse(
                                "0xFF${(expenseSnapshot.data ?? [])[index].category!.color!.replaceAll('#', '')}")),
                            name: (expenseSnapshot.data ?? [])[index].name!,
                            value: (expenseSnapshot.data ?? [])[index]
                                .value!
                                .toString(),
                          ));
                },
              ),
            )
          ],
        ),
      );
    }

    buildChart(BuildContext context, ExpenseController expenseController) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * .8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: FutureBuilder(
                  future: expenseController.getFilteredExpenses(
                    category: filter,
                    month: selectedMonth + 1,
                  ),
                  builder: (context, expenseSnapshot) {
                    return PieChart(
                      PieChartData(
                        sections: (expenseSnapshot.data ?? [])
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
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 75,
          leading: _getMonthsList(),
          leadingWidth: MediaQuery.of(context).size.width,
        ),
        body: Consumer<ExpenseController>(
          builder: (BuildContext context, ExpenseController expenseController,
                  Widget? child) =>
              Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomScrollView(slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  buildChart(context, expenseController),
                  buildHistory(
                    context,
                    expenseController,
                  ),
                ]),
              ),
            ]),
          ),
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
