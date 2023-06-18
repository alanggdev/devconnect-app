import 'package:dev_connect_app/env_keys.dart';
import 'package:dev_connect_app/features/post/presentation/bloc/post_bloc.dart';
import 'package:dev_connect_app/features/post/presentation/pages/home_screen.dart';
import 'package:dev_connect_app/features/post/presentation/pages/post_screen.dart';
import 'package:dev_connect_app/features/profile/presentation/pages/profile_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class FollowPostsScreen extends StatefulWidget {
  const FollowPostsScreen({super.key});

  @override
  State<FollowPostsScreen> createState() => _FollowPostsScreenState();
}

class _FollowPostsScreenState extends State<FollowPostsScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  int _userid = 0;

  @override
  void initState() {
    super.initState();
    _fetchUserId();
  }

  Future<void> _fetchUserId() async {
    SharedPreferences prefs = await _prefs;
    setState(() {
      _userid = prefs.getInt('id') ?? 0;
    });
    context.read<PostBloc>().add(GetFollowingPosts(userid: _userid));
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
                  'Dev Connect',
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
                  // context.read<PostBloc>().add(GetFollowingPosts());
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
                        Icon(Icons.home),
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
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const SearchUserScreen(),
              //       ),
              //     );
              //   },
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
              //   label: const Text('Buscar personas'),
              // ),
              BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is LoadingFollowingPosts) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LoadedFollowingPosts) {
                    if (state.followingPosts.isNotEmpty) {
                      return Column(
                        children: state.followingPosts.map((postPublic) {
                          final isLikedNotifier = ValueNotifier<bool>(
                              postPublic.likes!.contains(_userid));
                          return PostScreen(postPublic, isLikedNotifier);
                        }).toList(),
                      );
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/empty_posts.png',
                              height: 340,
                              width: 340,
                            ),
                            const Text(
                              'Aún no hay publicaciones para ver',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Color(0xff595B6E)),
                            ),
                          ],
                        ),
                      );
                    }
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
