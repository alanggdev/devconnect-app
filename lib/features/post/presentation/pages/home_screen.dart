import 'package:dev_connect_app/features/post/presentation/pages/follow_posts_screen.dart';
import 'package:dev_connect_app/features/post/presentation/pages/public_posts.dart';
import 'package:dev_connect_app/features/post/presentation/pages/settings_screen.dart';
import 'package:dev_connect_app/features/profile/presentation/pages/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;
  int useridvisit = 0;
  List<Widget> screens = [];

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
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = screens[1];
                            currentTab = 1;
                          });
                        },
                        minWidth: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.public,
                              color: currentTab == 1
                                  ? const Color(0xff6EBCDF)
                                  : Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = screens[2];
                            currentTab = 2;
                          });
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            currentScreen = screens[3];
                            currentTab = 3;
                          });
                        },
                        minWidth: 40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.settings,
                              color: currentTab == 3
                                  ? const Color(0xff6EBCDF)
                                  : Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
