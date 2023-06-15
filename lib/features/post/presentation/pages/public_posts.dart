import 'package:dev_connect_app/env_keys.dart';
import 'package:dev_connect_app/features/post/presentation/bloc/post_bloc.dart';
import 'package:dev_connect_app/features/post/presentation/pages/home_screen.dart';
import 'package:dev_connect_app/features/post/presentation/pages/post_screen.dart';
import 'package:dev_connect_app/features/profile/presentation/pages/profile_screen.dart';

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
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchUserScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.search),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xff6EBCDF),
                  minimumSize: const Size(150, 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shadowColor: Colors.black,
                  elevation: 6,
                ),
                label: const Text('Buscar'),
              ),
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

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({super.key});

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff3B47B6),
        elevation: 0,
        toolbarHeight: 60,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(
                Icons.navigate_before,
                size: 26,
              ),
              tooltip: 'Regresar',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 34,
              width: MediaQuery.of(context).size.width * 0.55,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Encontrar nuevas personas',
                  hintStyle: const TextStyle(
                    color: Color(0xff242C71),
                    fontSize: 12,
                  ),
                  filled: true,
                  fillColor: const Color(0xff7FE4ED),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 10,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 26,
              ),
              tooltip: 'Buscar',
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                String userToSearch = searchController.text.trim();
                if (userToSearch.isNotEmpty) {
                  context
                      .read<PostBloc>()
                      .add(SearchUser(username: userToSearch));
                }
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is SearchingUser) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserFound) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: state.users.map(
                      (user) {
                        return labelUsers(user);
                      },
                    ).toList(),
                    // children: [
                    //   labelUsers(),
                    //   labelUsers(),
                    //   labelUsers(),
                    //   labelUsers(),
                    //   labelUsers(),
                    //   labelUsers(),
                    //   labelUsers(),
                    //   labelUsers(),
                    //   labelUsers(),
                    //   labelUsers(),
                    //   labelUsers(),
                    //   labelUsers(),
                    // ],
                  ),
                ),
              ),
            );
          } else if (state is Error) {
            return Center(
              child:
                  Text(state.error, style: const TextStyle(color: Colors.red)),
            );
          } else {
            return const Center(
              child: Text(
                'Explora y descubre.',
              ),
            );
          }
        },
      ),
    );
  }

  Padding labelUsers(dynamic user) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(user['pk']),
                    ),
                  );
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffE1FCFF),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 40,
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
                            image: NetworkImage(
                                'https://${EnvKeys.serverURI}${user['profile']['avatar']}'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user['first_name']} ${user['last_name']}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user['username'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff6F707A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
