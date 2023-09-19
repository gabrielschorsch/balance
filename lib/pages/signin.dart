import 'package:app/pages/home.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String? username;
    String? password;
    String? confirmPassword;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Balance",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) => setState(() {
                          username = value;
                        }),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "O nome de usuário não pode ser vazio";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                          labelText: "Username",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) => setState(() {
                          password = value;
                        }),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "A senha não pode ser vazia";
                          }
                          if (value.length < 6) {
                            return "A senha deve possuir no mínimo 6 caracteres";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: Icon(
                            Icons.password,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: true,
                        validator: (value) {
                          if (value != password) {
                            return "As senhas não coincidem";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          prefixIcon: Icon(
                            Icons.password,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Button(
                        text: 'Cadastrar',
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final Color? color;
  final String text;
  final Color? textColor;
  final VoidCallback onPressed;

  const Button({
    Key? key,
    this.color,
    required this.text,
    this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          color ?? Theme.of(context).colorScheme.secondary,
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .65,
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: color ?? Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
      ),
    );
  }
}
