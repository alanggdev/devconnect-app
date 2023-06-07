import 'package:flutter/material.dart';

import 'package:dev_connect_app/features/session/presentation/pages/sign_in_screen.dart';
import 'package:dev_connect_app/features/session/presentation/widgets/text_field.dart';
import 'package:dev_connect_app/features/session/presentation/pages/create_profile.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final passConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 75,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Dev Connect',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        'Conectando a las personas',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text(
                        'Crear cuenta',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    textFieldForm(
                        Icons.email, 'Correo electrónico', emailController),
                    textFieldForm(
                        Icons.person, 'Nombre de usuario', usernameController),
                    textFieldForm(Icons.lock, 'Contraseña', passController),
                    textFieldForm(Icons.lock, 'Correo electrónico',
                        passConfirmController),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: TextButton.icon(
                        icon: const Icon(Icons.double_arrow_rounded),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xff3B47B6),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadowColor: Colors.black,
                          elevation: 6,
                        ),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          String emailText = emailController.text.trim();
                          String userText = usernameController.text.trim();
                          String passText = passController.text.trim();
                          String passConfirmText =
                              passConfirmController.text.trim();

                          if (emailText.isNotEmpty &&
                              userText.isNotEmpty &&
                              passText.isNotEmpty &&
                              passConfirmText.isNotEmpty) {
                            if (passText == passConfirmText) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateProfileScreen(
                                        emailText, userText, passText)),
                              );
                            } else {
                              FocusManager.instance.primaryFocus?.unfocus();
                              final BuildContext currentContext = context;
                              const snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('La contraseña no coincide.'),
                                duration: Duration(seconds: 3),
                              );
                              Future.microtask((() {
                                ScaffoldMessenger.of(currentContext)
                                    .showSnackBar(snackBar);
                              }));
                            }
                          } else {
                            FocusManager.instance.primaryFocus?.unfocus();
                            final BuildContext currentContext = context;
                            const snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Verifique los datos de ingreso.'),
                              duration: Duration(seconds: 3),
                            );
                            Future.microtask((() {
                              ScaffoldMessenger.of(currentContext)
                                  .showSnackBar(snackBar);
                            }));
                          }
                        },
                        label: const Text(
                          'Continuar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      '¿Ya tienes cuenta?',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 45, vertical: 8),
                    child: TextButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xff4DB181),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadowColor: Colors.black,
                        elevation: 6,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()),
                        );
                      },
                      child: const Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
