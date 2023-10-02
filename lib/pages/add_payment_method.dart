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

    final controller = context.watch<PaymentMethodController>();

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
                    )
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
                  if (!formKey.currentState!.validate()) {
                    return;
                  }

                  await controller
                      .addPaymentMethod(PaymentMethod(
                        name: nameController.value.text,
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
