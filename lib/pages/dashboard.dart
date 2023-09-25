import 'package:app/components/expense_card.dart';
import 'package:app/controllers/category_controller.dart';
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
  List<String> months = [
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

  @override
  Widget build(BuildContext context) {
    _controller.animateTo(selectedMonth * 80.0 - 160,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);

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
                                        builder: (context, expenseController,
                                                child) =>
                                            FutureBuilder(
                                          future:
                                              expenseController.getExpenses(),
                                          builder: (context, expenseSnapshot) {
                                            return PieChart(
                                              PieChartData(
                                                sections: (snapshot.data ?? [])
                                                    .map(
                                                      (e) =>
                                                          PieChartSectionData(
                                                        color: Color(int.parse(
                                                            "0xFF${e.color!.replaceAll('#', '')}")),
                                                        showTitle: false,
                                                        value: (expenseSnapshot
                                                                    .data ??
                                                                [])
                                                            .where((element) =>
                                                                element.category
                                                                    ?.id ==
                                                                e.id)
                                                            .map((e) => e.value)
                                                            .reduce((value,
                                                                    element) =>
                                                                value! +
                                                                element!),
                                                      ),
                                                    )
                                                    .toList(),
                                                pieTouchData: PieTouchData(
                                                  enabled: true,
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
                          }),
                ),
                Container(
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
                        ),
                        child: Text(
                          "Histórico",
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 20,
                        ),
                        child: Consumer<ExpenseController>(
                          builder: (context, expenseController, child) =>
                              FutureBuilder(
                                  future: expenseController.getExpenses(),
                                  builder: (context, expenseSnapshot) {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            (expenseSnapshot.data ?? []).length,
                                        itemBuilder: (_, index) => ExpenseCard(
                                              color: Color(int.parse(
                                                  "0xFF${expenseSnapshot.data![index].category!.color!.replaceAll('#', '')}")),
                                              name: expenseSnapshot
                                                  .data![index].name!,
                                              value: expenseSnapshot
                                                  .data![index].value!
                                                  .toString(),
                                            ));
                                  }),
                        ),
                      )
                    ],
                  ),
                ),
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
