import 'package:app/components/button.dart';
import 'package:app/controllers/category_controller.dart';
import 'package:app/domains/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  final List<String> availableColors = [
    "#FFB8B8",
    "#FFD8B8",
    "#FFFFB8",
    "#D8FFB8",
    "#B8FFC8",
    "#B8FFFF",
    "#B8D8FF",
    "#D8B8FF",
    "#FFB8F8",
  ];

  late String selectedColor;

  @override
  void initState() {
    super.initState();
    selectedColor = availableColors[0];
  }

  @override
  Widget build(BuildContext context) {
    final categoriesController = context.watch<CategoryController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "Adicionar nova categoria",
                style: Theme.of(context).textTheme.titleSmall!,
              ),
            ),
            Expanded(
              flex: 7,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    DropdownMenu(
                      width: MediaQuery.of(context).size.width * .8,
                      label: const Text(
                        "Selecione uma cor",
                        textAlign: TextAlign.center,
                      ),
                      leadingIcon: SizedBox(
                        height: 5,
                        width: 15,
                        child: Container(
                          height: 15,
                          width: 15,
                          color: Color(
                            int.parse(
                              selectedColor.replaceAll("#", "0xFF"),
                            ),
                          ),
                        ),
                      ),
                      dropdownMenuEntries: availableColors
                          .map(
                            (e) => DropdownMenuEntry(
                              leadingIcon: Container(
                                height: 15,
                                width: 15,
                                color:
                                    Color(int.parse(e.replaceAll("#", "0xFF"))),
                              ),
                              value: e,
                              label: '',
                            ),
                          )
                          .toList(),
                      onSelected: (value) => setState(() {
                        selectedColor = value!;
                      }),
                    ),
                    TextFormField(
                      controller: _budgetController,
                      decoration: const InputDecoration(
                        labelText: 'Orçamento mensal',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'O valor não pode ser vazio';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            Button(
                // formKey: _formKey,
                title: "Adicionar",
                onFormErrorMessage:
                    "Verifique todos os campos e tente novamente",
                formKey: _formKey,
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  await categoriesController
                      .addCategory(Category(
                    name: _nameController.text,
                    color: selectedColor,
                    budget: double.parse(_budgetController.text),
                  ))
                      .then((value) {
                    Navigator.of(context).pop();
                  });
                }),
          ],
        ),
      ),
    );
  }
}
