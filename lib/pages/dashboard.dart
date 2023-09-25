import 'package:app/components/expense_card.dart';
import 'package:app/domains/category.dart';
import 'package:app/domains/expense.dart';
import 'package:app/repository/categories_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

// List<Expense> mockupData = [
//   Expense(
//     id: "1",
//     category: mockupCategories[0],
//     name: "Almoço",
//     value: 20,
//   ),
//   Expense(
//     id: "2",
//     category: mockupCategories[0],
//     name: "Janta",
//     value: 20,
//   ),
//   Expense(
//     id: "3",
//     category: mockupCategories[1],
//     name: "Uber",
//     value: 10,
//     budget: 20,
//   ),
//   Expense(
//     id: "4",
//     category: mockupCategories[1],
//     name: "Ônibus",
//     value: 5,
//     budget: 20,
//   ),
//   Expense(
//     id: "5",
//     category: mockupCategories[2],
//     name: "Cinema",
//     value: 35,
//     budget: 50,
//   ),
// ];

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Future<List<Category>> categories =
        context.watch<CategoriesRepository>().getCategories();

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
                FutureBuilder(
                    future: categories,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //   Center(
                            //     child: SizedBox(
                            //       height: 200,
                            //       width: 200,
                            //       child: PieChart(
                            //         PieChartData(
                            //           sections: (snapshot.data ?? [])
                            //               .map((e) => PieChartSectionData(
                            //                     color: Color(int.parse(
                            //                         "0xFF${e.color!.replaceAll('#', '')}")),
                            //                     showTitle: false,
                            //                     value: mockupData
                            //                         .where((element) =>
                            //                             element.category?.id ==
                            //                             e.id)
                            //                         .map((e) => e.value)
                            //                         .reduce((value, element) =>
                            //                             value! + element!),
                            //                   ))
                            //               .toList(),
                            //           pieTouchData: PieTouchData(
                            //             enabled: true,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                          ],
                        ),
                      );
                    }),
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
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //     left: 15,
                      //     top: 20,
                      //   ),
                      //   child: ListView.builder(
                      //       shrinkWrap: true,
                      //       itemCount: mockupData.length,
                      //       itemBuilder: (_, index) => ExpenseCard(
                      //             color: Color(int.parse(
                      //                 "0xFF${mockupData[index].category!.color!.replaceAll('#', '')}")),
                      //             name: mockupData[index].name!,
                      //             value: mockupData[index].value!.toString(),
                      //           )),
                      // )
                    ],
                  ),
                ),
              ]),
            ),
          ]),
        ));
  }

  _buildHistory(BuildContext context) {
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
            ),
            child: Text(
              "Histórico",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     left: 15,
          //     top: 20,
          //   ),
          //   child: ListView.builder(
          //       shrinkWrap: true,
          //       itemCount: mockupData.length,
          //       itemBuilder: (_, index) => ExpenseCard(
          //             color: Color(int.parse(
          //                 "0xFF${mockupData[index].category!.color!.replaceAll('#', '')}")),
          //             name: mockupData[index].name!,
          //             value: mockupData[index].value!.toString(),
          //           )),
          // )
        ],
      ),
    );
  }

  // _buildChart() {
  //   return Center(
  //     child: SizedBox(
  //       height: 200,
  //       width: 200,
  //       child: PieChart(
  //         PieChartData(
  //           sections: mockupCategories
  //               .map((e) => PieChartSectionData(
  //                     color: Color(
  //                         int.parse("0xFF${e.color!.replaceAll('#', '')}")),
  //                     showTitle: false,
  //                     value: mockupData
  //                         .where((element) => element.category?.id == e.id)
  //                         .map((e) => e.value)
  //                         .reduce((value, element) => value! + element!),
  //                   ))
  //               .toList(),
  //           pieTouchData: PieTouchData(
  //             enabled: true,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
