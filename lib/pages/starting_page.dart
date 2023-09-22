import 'package:flutter/material.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({super.key});

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {


  @override
  Widget build(BuildContext context) {
    List<Widget> containers = [
      const SizedBox(
        height: 20,
      ),
      const ValueContainer(title: "Este mês você gastou:", value: 250),
      const SizedBox(
        height: 20,
      ),
      const ValueContainer(title: "Total planejado:", value: 550),
    ];
    
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Olá, Gabriel",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ...containers,
          ],
        ),
      ),
    );
  }
}

class ValueContainer extends StatelessWidget {
  final String title;
  final double value;

  const ValueContainer({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
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
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.background,
                          ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "R\$ ${value.toStringAsFixed(2).replaceAll(".", ",")}",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Theme.of(context).colorScheme.background,
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
