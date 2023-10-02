import 'package:app/components/button.dart';
import 'package:app/controllers/payment_method_controller.dart';
import 'package:app/domains/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPaymentMethod extends StatefulWidget {
  const AddPaymentMethod({super.key});

  @override
  State<AddPaymentMethod> createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final List<IconData> icons = [
      Icons.credit_card,
      Icons.money,
      Icons.money_off,
      Icons.card_giftcard,
      Icons.card_membership,
      Icons.card_travel,
    ];

    final controller = context.watch<PaymentMethodController>();

    IconData? selectedIcon;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "Adicionar novo método de pagamento",
                style: Theme.of(context).textTheme.titleSmall!,
              ),
            ),
            Expanded(
              flex: 7,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
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
                      child: DropdownMenu<IconData>(
                        width: MediaQuery.of(context).size.width * .95,
                        label: const Text("Ícone"),
                        onSelected: (value) {
                          setState(() {
                            selectedIcon = value;
                          });
                        },
                        dropdownMenuEntries: icons
                            .map(
                              (element) => DropdownMenuEntry<IconData>(
                                  style: ButtonStyle(
                                    padding: const MaterialStatePropertyAll(
                                        EdgeInsets.zero),
                                    alignment: Alignment.centerLeft,
                                    minimumSize: MaterialStatePropertyAll(
                                      Size(
                                        MediaQuery.of(context).size.width * .25,
                                        50,
                                      ),
                                    ),
                                    maximumSize: MaterialStatePropertyAll(
                                      Size(
                                        MediaQuery.of(context).size.width * .25,
                                        50,
                                      ),
                                    ),
                                  ),
                                  label: "",
                                  leadingIcon: Icon(
                                    element,
                                    color: selectedIcon == element
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).iconTheme.color,
                                  ),
                                  value: element),
                            )
                            .toList(),
                      ),
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
                formKey: formKey,
                onPressed: () async {
                  if (!formKey.currentState!.validate() ||
                      selectedIcon == null) {
                    return;
                  }
                  await controller
                      .addPaymentMethod(PaymentMethod(
                        name: nameController.value.text,
                        icon: selectedIcon!.codePoint,
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
