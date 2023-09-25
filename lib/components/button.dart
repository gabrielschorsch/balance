import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final String title;
  final VoidCallback? onPressed;
  final String onFormErrorMessage;
  const Button(
      {super.key,
      this.formKey,
      required this.title,
      this.onPressed,
      this.onFormErrorMessage = ""});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (formKey == null) {
          onPressed!();
          return;
        } else if (formKey!.currentState!.validate()) {
          onPressed!();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(onFormErrorMessage),
            ),
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .5,
        height: MediaQuery.of(context).size.height * .1,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.kanit(
              color: Colors.white,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
