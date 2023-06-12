import 'package:dev_connect_app/features/post/domain/entities/post.dart';
import 'package:dev_connect_app/features/post/presentation/bloc/post_bloc.dart';
import 'package:dev_connect_app/features/profile/presentation/bloc/profile_bloc.dart'
    as profile_bloc;
import 'package:dev_connect_app/features/post/presentation/pages/follow_posts_screen.dart';
import 'package:dev_connect_app/features/post/presentation/pages/public_posts.dart';
import 'package:dev_connect_app/features/post/presentation/pages/settings_screen.dart';
import 'package:dev_connect_app/features/profile/presentation/pages/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;
  int useridvisit = 0;
  List<Widget> screens = [];

  File? file;

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
      setState(() {});
      final BuildContext currentContext = context;
      Future.microtask(() {
        const snackBar = SnackBar(
          content: Text('Imagen subida'),
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(currentContext).showSnackBar(snackBar);
      });
    }
  }

  Future<void> getVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickVideo(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
      setState(() {});
      final BuildContext currentContext = context;
      Future.microtask(() {
        const snackBar = SnackBar(
          content: Text('Imagen subida'),
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(currentContext).showSnackBar(snackBar);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getIDUserVisit();
  }

  Future<void> getIDUserVisit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    useridvisit = prefs.getInt('id')!;

    setState(() {
      screens = [
        const PublicPostsScreen(),
        const FollowPostsScreen(),
        ProfileScreen(useridvisit),
        const SettingsScreen(),
      ];
    });
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const PublicPostsScreen();

  @override
  Widget build(BuildContext context) {
    final postController = TextEditingController();
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          file = null;
          postController.clear();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                contentPadding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                content: commentLabel(context, postController, useridvisit),
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Color(0xff3B47B6),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        child: BottomAppBar(
          color: const Color(0xff3B47B6),
          // shape: const CircularNotchedRectangle(),
          // notchMargin: 10,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = screens[0];
                            currentTab = 0;
                          });
                        },
                        minWidth: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: currentTab == 0
                                  ? const Color(0xff6EBCDF)
                                  : Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 5),
                    //   child: MaterialButton(
                    //     onPressed: () {
                    //       setState(() {
                    //         currentScreen = screens[1];
                    //         currentTab = 1;
                    //       });
                    //     },
                    //     minWidth: 40,
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Icon(
                    //           Icons.public,
                    //           color: currentTab == 1
                    //               ? const Color(0xff6EBCDF)
                    //               : Colors.white,
                    //           size: 30,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: MaterialButton(
                        onPressed: () {
                          // setState(() {
                          //   currentScreen = screens[2];
                          //   currentTab = 2;
                          // });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(useridvisit),
                            ),
                          );
                        },
                        minWidth: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_circle,
                              color: currentTab == 2
                                  ? const Color(0xff6EBCDF)
                                  : Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 15),
                    //   child: MaterialButton(
                    //     onPressed: () {
                    //       setState(() {
                    //         currentScreen = screens[3];
                    //         currentTab = 3;
                    //       });
                    //     },
                    //     minWidth: 40,
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Icon(
                    //           Icons.settings,
                    //           color: currentTab == 3
                    //               ? const Color(0xff6EBCDF)
                    //               : Colors.white,
                    //           size: 30,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox commentLabel(BuildContext context,
      TextEditingController commentController, int userid) {
    context
        .read<profile_bloc.ProfileBloc>()
        .add(profile_bloc.GetProfile(userid: useridvisit));
    return SizedBox(
      child: BlocBuilder<profile_bloc.ProfileBloc, profile_bloc.ProfileState>(
          builder: (context, stateProfile) {
        if (stateProfile is profile_bloc.LoadingProfile) {
          return const SizedBox(
            height: 60,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (stateProfile is profile_bloc.LoadedProfile) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 165,
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                                        stateProfile.profile.avatarURL),
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
                                    '${stateProfile.profile.user['first_name']} ${stateProfile.profile.user['last_name']}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    stateProfile.profile.user['username'],
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
                        SizedBox(
                          width: 85,
                          child: TextButton(
                            onPressed: () {
                              String commentText =
                                  commentController.text.trim();
                              if (commentText.isNotEmpty) {
                                DateTime now = DateTime.now();
                                String formattedDate =
                                    DateFormat('dd/MM/yyyy hh:mma').format(now);
                                context.read<PostBloc>().add(CreatePost(
                                    userid: useridvisit,
                                    description: commentText,
                                    date: formattedDate,
                                    mediaFile: file));

                                Navigator.pop(context);
                                context.read<PostBloc>().add(GetPublicPosts());
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xff5D95D1),
                              minimumSize: const Size(150, 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              shadowColor: Colors.black,
                              elevation: 6,
                            ),
                            child: const Text('Publicar'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      minLines: 1,
                      maxLines: 6,
                      controller: commentController,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Publicar algo...')),
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 48,
                          child: TextButton.icon(
                            icon: const Icon(Icons.image),
                            onPressed: () {
                              getImage();
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color(0xff5D95D1),
                              minimumSize: const Size(150, 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              shadowColor: Colors.black,
                              elevation: 6,
                            ),
                            label: Container(),
                          ),
                        ),
                        
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: SizedBox(
                            width: 48,
                            child: TextButton.icon(
                              icon: const Icon(Icons.videocam),
                              onPressed: () {
                                getVideo();
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: const Color(0xff5D95D1),
                                minimumSize: const Size(150, 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                shadowColor: Colors.black,
                                elevation: 6,
                              ),
                              label: Container(),
                            ),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (stateProfile is profile_bloc.Error) {
          return Center(
            child: Text(stateProfile.error,
                style: const TextStyle(color: Colors.red)),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
