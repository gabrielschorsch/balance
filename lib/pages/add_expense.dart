import 'package:app/components/button.dart';
import 'package:app/domains/category.dart';
import 'package:app/repository/categories_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatelessWidget {
  AddExpense({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _dateController.value = TextEditingValue(
      text: DateTime.now().toString().split(" ")[0],
    );
    _dateController.text = DateTime.now()
        .toString()
        .split(" ")[0]
        .split("-")
        .reversed
        .join("-")
        .replaceAll("-", "/");
    final Future<List<Category>> categories =
        context.watch<CategoriesRepository>().getCategories();
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
                "Adicionar nova despesa",
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
                    // dropdown
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: FutureBuilder<List<Category>>(
                          future: categories,
                          builder: (context, snapshot) {
                            return DropdownMenu(
                              width: MediaQuery.of(context).size.width * .95,
                              label: const Text("Categoria"),
                              dropdownMenuEntries: (snapshot.data ??
                                      [] as List<Category>)
                                  .map((element) => DropdownMenuEntry(
                                        style: ButtonStyle(
                                          padding:
                                              const MaterialStatePropertyAll(
                                                  EdgeInsets.zero),
                                          alignment: Alignment.centerLeft,
                                          minimumSize: MaterialStatePropertyAll(
                                            Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .95,
                                              50,
                                            ),
                                          ),
                                        ),
                                        label: element.name ?? "",
                                        value: element.id,
                                      ))
                                  .toList(),
                            );
                          }),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Valor',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'O valor não pode ser vazio';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _dateController,
                      decoration: const InputDecoration(
                        labelText: 'Data',
                      ),
                      readOnly: true,
                      onTap: () async {
                        var pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              DateTime.now().year, DateTime.now().month - 1),
                          lastDate: DateTime(DateTime.now().year + 2),
                        );
                        if (pickedDate != null) {
                          _dateController.value = TextEditingValue(
                            text: pickedDate.toString().split(" ")[0],
                          );
                          _dateController.text = pickedDate
                              .toString()
                              .split(" ")[0]
                              .split("-")
                              .reversed
                              .join("-")
                              .replaceAll("-", "/");
                        }
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
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }
}
