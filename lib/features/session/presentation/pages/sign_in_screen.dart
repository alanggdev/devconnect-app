import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dev_connect_app/features/session/presentation/widgets/text_field.dart';
import 'package:dev_connect_app/features/session/presentation/bloc/session_bloc.dart';
import 'package:dev_connect_app/features/profile/presentation/pages/profile_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final usernameController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<SessionBloc, SessionState>(
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
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
                                'Iniciar sesión',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            textFieldForm(Icons.person, 'Nombre de usuario',
                                usernameController),
                            textFieldForm(
                                Icons.lock, 'Contraseña', passController),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              child: TextButton.icon(
                                icon: const Icon(Icons.login),
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
                                  String usernameText =
                                      usernameController.text.trim();
                                  String passText = passController.text.trim();

                                  if (usernameText.isNotEmpty &&
                                      passText.isNotEmpty) {
                                    context.read<SessionBloc>().add(LogIn(
                                        username: usernameText,
                                        password: passText));
                                  } else {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    final BuildContext currentContext = context;
                                    const snackBar = SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          'Verifique los datos de ingreso.'),
                                      duration: Duration(seconds: 3),
                                    );
                                    Future.microtask((() {
                                      ScaffoldMessenger.of(currentContext)
                                          .showSnackBar(snackBar);
                                    }));
                                  }
                                },
                                label: const Text(
                                  'Ingresar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
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
                              '¿No tienes cuenta?',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 45, vertical: 8),
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
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Crear cuenta',
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
              if (state is SigningIn)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (state is SignedIn)
                FutureBuilder(
                  future: Future.delayed(Duration.zero, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  }),
                  builder: (context, snapshot) {
                    return Container();
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
