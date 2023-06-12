import 'package:dev_connect_app/features/post/presentation/bloc/post_bloc.dart';
import 'package:dev_connect_app/features/post/presentation/pages/post_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class PublicPostsScreen extends StatefulWidget {
  const PublicPostsScreen({super.key});

  @override
  State<PublicPostsScreen> createState() => _PublicPostsScreenState();
}

class _PublicPostsScreenState extends State<PublicPostsScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int>? _userid;

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(GetPublicPosts());
    _userid = _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('id') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF4F4F4),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff3B47B6),
          elevation: 0,
          toolbarHeight: 60,
          title: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 35,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 18),
                child: Text(
                  'Hola!',
                  style: TextStyle(
                    // color: CustomColors.baseLightBlue,
                    fontSize: 26,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.autorenew,
                  size: 26,
                ),
                tooltip: 'Actualizar',
                onPressed: () {
                  context.read<PostBloc>().add(GetPublicPosts());
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: const Color(0xff3B47B6),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffF4F4F4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: const [
                        Icon(Icons.public),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Publicaciones',
                            style: TextStyle(
                              // color: PrimaryColors.grayBlue,
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Divider(
                  thickness: 1,
                  height: 1,
                  color: Color(0xff3B47B6),
                ),
              ),
              // TextButton.icon(
              //   onPressed: () {},
              //   icon: const Icon(Icons.search),
              //   style: OutlinedButton.styleFrom(
              //     foregroundColor: Colors.white,
              //     backgroundColor: const Color(0xff6EBCDF),
              //     minimumSize: const Size(150, 8),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     shadowColor: Colors.black,
              //     elevation: 6,
              //   ),
              //   label: const Text('Buscar'),
              // ),
              BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is LoadingPublicPosts) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedPublicPosts) {
                    return FutureBuilder<int>(
                        future: _userid,
                        builder: (BuildContext context,
                            AsyncSnapshot<int> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case ConnectionState.active:
                            case ConnectionState.done:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return Column(
                                  children: state.publicPosts.map((postPublic) {
                                    final isLikedNotifier = ValueNotifier<bool>(
                                        postPublic.likes!
                                            .contains(snapshot.data));
                                    //
                                    return PostScreen(
                                        postPublic, isLikedNotifier);
                                  }).toList(),
                                );
                              }
                          }
                        });
                  } else if (state is Error) {
                    return Center(
                      child: Text(state.error,
                          style: const TextStyle(color: Colors.red)),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
