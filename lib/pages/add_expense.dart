import 'package:app/components/button.dart';
import 'package:app/controllers/category_controller.dart';
import 'package:app/controllers/expense_controller.dart';
import 'package:app/controllers/payment_method_controller.dart';
import 'package:app/domains/category.dart';
import 'package:app/domains/expense.dart';
import 'package:app/domains/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _valueController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();
  Category? _selectedCategory;
  PaymentMethod? _selectedPaymentMethod;

  @override
  void initState() {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Future<List<Category>> categories =
        context.watch<CategoryController>().getCategories();
    final paymentMethods =
        context.watch<PaymentMethodController>().getPaymentMethods();
    final expenseController = context.watch<ExpenseController>();
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: FutureBuilder<List<Category>>(
                          future: categories,
                          builder: (context, snapshot) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                value: _selectedCategory,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCategory = value as Category;
                                  });
                                },
                                hint: const Text(
                                  "Categorias",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                items: (snapshot.data ?? []).map((element) {
                                  return DropdownMenuItem(
                                    value: element,
                                    child: Text(
                                      element.name ?? "",
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: FutureBuilder<List<PaymentMethod>>(
                          future: paymentMethods,
                          builder: (context, snapshot) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                value: _selectedPaymentMethod,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedPaymentMethod =
                                        value as PaymentMethod;
                                  });
                                },
                                hint: const Text(
                                  "Formas de pagamento",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                                items: snapshot.data!.map((element) {
                                  return DropdownMenuItem(
                                    value: element,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          IconData(element.icon!,
                                              fontFamily: "MaterialIcons"),
                                        ),
                                        const SizedBox(width: 30),
                                        Text(
                                          element.name ?? "",
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                    ),
                    TextFormField(
                      controller: _descriptionController,
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
                      controller: _valueController,
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
                          setState(() {
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
                          });
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
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  DateTime? date = DateTime.tryParse(
                      _dateController.value.text.split("/").reversed.join("-"));
                  DateTime? now = DateTime.now();

                  await expenseController
                      .addExpense(Expense(
                        name: _nameController.value.text,
                        description: _descriptionController.value.text,
                        value: date!.isBefore(now) || date.isAtSameMomentAs(now)
                            ? double.tryParse(_valueController.value.text)
                            : -1,
                        budget: date.isAfter(now)
                            ? double.tryParse(_valueController.value.text)
                            : -1,
                        date: date,
                        category: _selectedCategory,
                        paymentMethod: _selectedPaymentMethod
                      ))
                      .then(
                        (value) => Navigator.of(context).pop(),
                      );
                }),
          ],
        ),
      ),
    );
  }
}
