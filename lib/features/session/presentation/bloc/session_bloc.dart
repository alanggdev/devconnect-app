import 'package:dev_connect_app/features/session/domain/entities/sign_in.dart';
import 'package:dev_connect_app/features/session/domain/entities/sign_up.dart';
import 'package:dev_connect_app/features/session/domain/usecases/sign_in.dart';
import 'package:dev_connect_app/features/session/domain/usecases/sign_up.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  SessionBloc({required this.signInUseCase, required this.signUpUseCase})
      : super(InitialState()) {
    on<SessionEvent>((event, emit) async {
      if (event is LogIn) {
        try {
          emit(SigningIn());
          final SignIn signInData =
              SignIn(username: event.username, password: event.password);
          String signInStatus = await signInUseCase.execute(signInData);
          emit(SignedIn(signInStatus: signInStatus));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } else if (event is Register) {
        emit(SigningUp());
        final SignUp signUpData = SignUp(
            username: event.username,
            email: event.email,
            firstname: event.firstname,
            lastname: event.lastname,
            password: event.password,
            avatar: event.avatar,
            description: event.description,
            status: event.status);
        String signUpStatus = await signUpUseCase.execute(signUpData);
        emit(SignedUp(signUpStatus: signUpStatus));
      }
    });
  }
}
