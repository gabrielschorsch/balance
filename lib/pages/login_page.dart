import 'package:app/controllers/auth_controller.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

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
                        controller: emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "O e-mail não pode ser vazio";
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
                          labelText: "E-mail",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      const SizedBox(height: 50),
                      Button(
                        text: 'Login',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            var logged =
                                await context.read<AuthController>().login(
                                      emailController.text,
                                      passwordController.text,
                                    );
                            if (logged) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const Home(),
                                ),
                              );
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "E-mail ou senha incorretos",
                                  ),
                                ),
                              );
                            }
                          }
                        },
                      ),
                      Button(
                        text: 'Cadastro',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignInPage(),
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
