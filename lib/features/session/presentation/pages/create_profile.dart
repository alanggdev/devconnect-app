import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dev_connect_app/features/session/presentation/pages/sign_in_screen.dart';
import 'package:dev_connect_app/features/session/presentation/widgets/text_field.dart';
import 'package:dev_connect_app/features/session/presentation/bloc/session_bloc.dart';

class CreateProfileScreen extends StatefulWidget {
  final String email, user, pass;
  const CreateProfileScreen(this.email, this.user, this.pass, {super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final statusController = TextEditingController();
  final descriptionController = TextEditingController();
  File? file;

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: BlocBuilder<SessionBloc, SessionState>(builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.navigate_before,
                            color: Colors.black,
                          ),
                          label: const Text(
                            'Regresar',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              width: 75,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(6),
                              child: Text(
                                'Crear perfil',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.user,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.email,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text(
                                'Foto de perfil',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Container(
                                    width: 65,
                                    height: 65,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 5,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: file == null
                                            ? const NetworkImage(
                                                'https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg')
                                            : FileImage(file!)
                                                as ImageProvider<Object>,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: TextButton.icon(
                                      icon: const Icon(Icons.upload),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            const Color(0xff4DB181),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        shadowColor: Colors.black,
                                        elevation: 6,
                                      ),
                                      onPressed: () {
                                        getImage();
                                      },
                                      label: const Text(
                                        'Subir imagen',
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
                            textFieldForm(
                                Icons.person, 'Nombre', firstNameController),
                            textFieldForm(
                                Icons.person, 'Apellido', lastNameController),
                            textFieldForm(
                                Icons.add_reaction, 'Estado', statusController),
                            textFieldForm(Icons.description, 'Descripción',
                                descriptionController),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              child: TextButton.icon(
                                icon: const Icon(Icons.create),
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
                                  String firstnameText =
                                      firstNameController.text.trim();
                                  String lastnameText =
                                      lastNameController.text.trim();
                                  String statusText =
                                      statusController.text.trim();
                                  String descriptionText =
                                      descriptionController.text.trim();

                                  if (firstnameText.isNotEmpty &&
                                      lastnameText.isNotEmpty &&
                                      statusText.isNotEmpty &&
                                      descriptionText.isNotEmpty &&
                                      file != null) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    context.read<SessionBloc>().add(Register(
                                        username: widget.user,
                                        email: widget.email,
                                        password: widget.pass,
                                        firstname: firstnameText,
                                        lastname: lastnameText,
                                        avatar: file!,
                                        description: descriptionText,
                                        status: statusText));
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
                            // if (isUploaded)
                            // Image.file(File(file.))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (state is SigningUp)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (state is SignedUp)
              FutureBuilder(
                future: Future.delayed(Duration.zero, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                }),
                builder: (context, snapshot) {
                  return Container();
                },
              ),
          ],
        );
      }),
    );
  }
}
