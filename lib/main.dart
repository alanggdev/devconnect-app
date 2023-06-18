import 'package:dev_connect_app/features/post/presentation/bloc/post_bloc.dart';
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
                getProfileUseCase: usecaseConfig.getProfileUseCase!,
                getProfilePostsUseCase: usecaseConfig.getProfilePostsUseCase!,
                updateProfileUseCase: usecaseConfig.updateProfileUseCase!)),
        BlocProvider<PostBloc>(
            create: (BuildContext context) => PostBloc(
                updatePostUseCase: usecaseConfig.updatePostUseCase!,
                getAllPostsUseCase: usecaseConfig.getAllPostsUseCase!,
                getDetailPostUseCase: usecaseConfig.getDetailPostUseCase!,
                getPostCommentsUseCase: usecaseConfig.getPostCommentsUseCase!,
                createCommentUseCase: usecaseConfig.createCommentUseCase!,
                createPostUseCase: usecaseConfig.createPostUseCase!,
                searchUserUseCase: usecaseConfig.searchUserUseCase!,
                getFollowingPostsUseCase: usecaseConfig.getFollowingPostsUseCase!)),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}
