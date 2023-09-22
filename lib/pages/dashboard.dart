import 'package:app/components/expense_card.dart';
import 'package:app/domains/category.dart';
import 'package:app/domains/expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

List<Category> mockupCategories = [
  Category(
    id: "1",
    color: "#FF0000",
    name: "Alimentação",
  ),
  Category(
    id: "2",
    color: "#00FF00",
    name: "Transporte",
  ),
  Category(
    id: "3",
    color: "#0000FF",
    name: "Lazer",
  ),
];

List<Expense> mockupData = [
  Expense(
    id: "1",
    category: mockupCategories[0],
    name: "Almoço",
    value: 20,
  ),
  Expense(
    id: "2",
    category: mockupCategories[0],
    name: "Janta",
    value: 20,
  ),
  Expense(
    id: "3",
    category: mockupCategories[1],
    name: "Uber",
    value: 10,
    budget: 20,
  ),
  Expense(
    id: "4",
    category: mockupCategories[1],
    name: "Ônibus",
    value: 5,
    budget: 20,
  ),
  Expense(
    id: "5",
    category: mockupCategories[2],
    name: "Cinema",
    value: 35,
    budget: 50,
  ),
];

String? get currentMonth => {
      1: "Janeiro",
      2: "Fevereiro",
      3: "Março",
      4: "Abril",
      5: "Maio",
      6: "Junho",
      7: "Julho",
      8: "Agosto",
      9: "Setembro",
      10: "Outubro",
      11: "Novembro",
      12: "Dezembro",
    }[DateTime.now().month];

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.filter_list_rounded,
                size: 48,
              ),
            ),
          ],
        ),
        body: CustomScrollView(slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              _buildChartSection(context),
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
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: mockupData.length,
                          itemBuilder: (_, index) => ExpenseCard(
                                color: Color(int.parse(
                                    "0xFF${mockupData[index].category!.color!.replaceAll('#', '')}")),
                                name: mockupData[index].name!,
                                value: mockupData[index].value!.toString(),
                              )),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ]));
  }

  Widget _buildChartSection(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
            ),
            child: Text(
              currentMonth!,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.start,
            ),
          ),
          Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: PieChart(
                PieChartData(
                  sections: mockupCategories
                      .map((e) => PieChartSectionData(
                            color: Color(int.parse(
                                "0xFF${e.color!.replaceAll('#', '')}")),
                            showTitle: false,
                            value: mockupData
                                .where(
                                    (element) => element.category?.id == e.id)
                                .map((e) => e.value)
                                .reduce((value, element) => value! + element!),
                          ))
                      .toList(),
                  pieTouchData: PieTouchData(
                    enabled: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double get _getTotalExpenses {
    double total = 0;
    for (var element in mockupData) {
      total += element.value!;
    }
    return total;
  }

  double get _getPlannedExpenses {
    double total = 0;
    for (Expense e in mockupData) {
      total += e.budget ?? 0;
    }
    return total;
  }
}
