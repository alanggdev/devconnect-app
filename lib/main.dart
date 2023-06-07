import 'package:dev_connect_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dev_connect_app/features/session/presentation/bloc/session_bloc.dart';
import 'package:dev_connect_app/usecase_config.dart';
import 'package:dev_connect_app/welcome.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

UseCaseConfig usecaseConfig = UseCaseConfig();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SessionBloc>(
            create: (BuildContext context) => SessionBloc(
                signInUseCase: usecaseConfig.signInUseCase!,
                signUpUseCase: usecaseConfig.signUpUseCase!)),
        BlocProvider<ProfileBloc>(
            create: (BuildContext context) => ProfileBloc(
                getOwnProfileUseCase: usecaseConfig.getOwnProfileUseCase!)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}
