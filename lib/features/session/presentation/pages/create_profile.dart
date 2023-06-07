import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  bool isUploaded = false;
  File? file;

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
      setState(() {
        isUploaded = true;
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
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
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
                  ),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
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
                                      backgroundColor: const Color(0xff4DB181),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
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

                                print(widget.email);
                                print(widget.user);
                                print(widget.pass);
                                print(firstnameText);
                                print(lastnameText);
                                print(statusText);
                                print(descriptionText);
                                print(file);

                                if (firstnameText.isNotEmpty &&
                                    lastnameText.isNotEmpty &&
                                    statusText.isNotEmpty &&
                                    descriptionText.isNotEmpty &&
                                    file != null) {
                                  context.read<SessionBloc>().add(Register(
                                      username: widget.user,
                                      email: widget.email,
                                      password: widget.pass,
                                      firstname: firstnameText,
                                      lastname: lastnameText,
                                      avatar: file!,
                                      description: descriptionText,
                                      status: statusText));
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
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
