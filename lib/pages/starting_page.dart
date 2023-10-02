import 'package:app/controllers/expense_controller.dart';
import 'package:app/domains/expense.dart';
import 'package:app/pages/add_category.dart';
import 'package:app/pages/add_payment_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({super.key});

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  @override
  Widget build(BuildContext context) {
    final _controller = context.watch<ExpenseController>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 400,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder<List<Expense>>(
              future: _controller.getExpenses(),
              builder: (context, snapshot) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Olá, Gabriel",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white),
                    ),
                    ValueContainer(
                      title: "Este mês você gastou:",
                      value: (snapshot.data ?? [])
                          .where((element) =>
                              element.date!.month == DateTime.now().month)
                          .toList()
                          .fold<double>(
                            0,
                            (previousValue, element) =>
                                previousValue +
                                (element.value! > 0 ? element.value! : 0),
                          ),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      titleColor: Colors.white,
                      valueColor: Colors.red[200],
                    ),
                    ValueContainer(
                      title: "Valor planejado:",
                      value: (snapshot.data ?? [])
                          .where((element) =>
                              element.date!.month == DateTime.now().month)
                          .toList()
                          .fold<double>(
                              0,
                              (previousValue, element) =>
                                  previousValue +
                                  ((element.budget ?? 0) > 0
                                      ? element.budget!
                                      : 0)),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      titleColor: Colors.white,
                      valueColor: Colors.green[200],
                    ),
                  ],
                );
              }),
        ),
        leadingWidth: MediaQuery.of(context).size.width * .8,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: LayoutBuilder(builder: (context, constraint) {
          return GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: constraint.maxHeight / 2 - 20,
              crossAxisSpacing: 25,
              mainAxisSpacing: 15,
            ),
            children: [
              NavigatorButton(
                icon: Icons.add_box,
                text: "Adicionar nova categoria",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddCategory(),
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),
              NavigatorButton(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddPaymentMethod(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                text: "Adicionar forma de pagamento",
                icon: Icons.credit_card,
              )
            ],
          );
        }),
      ),
    );
  }
}

class NavigatorButton extends StatelessWidget {
  final Null Function() onTap;
  final String text;
  final IconData icon;

  const NavigatorButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.secondary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 48,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class ValueContainer extends StatelessWidget {
  final String title;
  final double value;
  final Color? titleColor, valueColor, backgroundColor;

  const ValueContainer({
    super.key,
    required this.title,
    required this.value,
    this.titleColor,
    this.valueColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: LayoutBuilder(builder: (context, constraint) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .15,
              width: constraint.maxWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: backgroundColor ?? Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: titleColor ??
                                Theme.of(context).colorScheme.background,
                          ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "R\$ ${value.toStringAsFixed(2).replaceAll(".", ",")}",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: valueColor ??
                                Theme.of(context).colorScheme.background,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
