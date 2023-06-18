import 'package:dev_connect_app/env_keys.dart';
import 'package:dev_connect_app/features/post/presentation/pages/home_screen.dart';
import 'package:dev_connect_app/features/post/presentation/pages/profile_posts_screen.dart';
import 'package:dev_connect_app/features/profile/presentation/bloc/profile_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final int userid;
  const ProfileScreen(this.userid, {super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int? useridvisit;
  bool? showBack;
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfile(userid: widget.userid));
    _tabController = TabController(length: 1, vsync: this);
    getIDUserVisit();
  }

  Future<void> getIDUserVisit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    useridvisit = prefs.getInt('id');
    setState(() {
      if (useridvisit == widget.userid) {
        showBack = false;
      } else {
        showBack = true;
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF4F4F4),
        appBar: AppBar(
          elevation: 2,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffF4F4F4),
          title: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            child: Row(
              children: const [
                Icon(
                  Icons.navigate_before,
                  color: Colors.black,
                ),
                Text(
                  'Regresar',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.autorenew,
                  size: 26,
                  color: Colors.black,
                ),
                tooltip: 'Actualizar',
                onPressed: () {
                  context
                      .read<ProfileBloc>()
                      .add(GetProfile(userid: widget.userid));
                },
              ),
            ),
          ],
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is LoadingProfile) {
            return Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is LoadedProfile) {
            final bool isFollowed = state.profile.followers
                .toString()
                .contains(useridvisit.toString());
            return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      pinned: false,
                      backgroundColor: Colors.white,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        background: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(
                                child: Container(
                                  width: 150,
                                  height: 150,
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
                                      image:
                                          NetworkImage(state.profile.avatarURL),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${state.profile.user['first_name']} ${state.profile.user['last_name']}',
                                            style: const TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff242C71)),
                                          ),
                                          Text(
                                            '@${state.profile.user['username']}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Color(0xff3B47B6)),
                                          ),
                                        ],
                                      ),
                                      if (state.profile.userId != useridvisit)
                                        SizedBox(
                                          width: 100,
                                          child: TextButton(
                                            onPressed: () {
                                              context.read<ProfileBloc>().add(
                                                  FollowProfile(
                                                      profileid:
                                                          state.profile.id,
                                                      userid: useridvisit!,
                                                      profileuserid: state
                                                          .profile.userId));
                                              context.read<ProfileBloc>().add(
                                                  GetProfile(
                                                      userid: widget.userid));
                                            },
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor: isFollowed
                                                  ? const Color(0xff242C71)
                                                  : const Color(0xff6EBCDF),
                                              minimumSize: const Size(150, 8),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              shadowColor: Colors.black,
                                              elevation: 6,
                                            ),
                                            child: Text(isFollowed
                                                ? "Siguiendo"
                                                : "Seguir"),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Status: ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff6F707A),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          state.profile.status,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff6F707A)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      state.profile.description,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff6F707A)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return followersInfo(context,
                                                    state.profile.following, 'Siguiendo');
                                              },
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                state.profile.following.length
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0xff242C71)),
                                              ),
                                              const Text(
                                                "Seguidos",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0xff242C71)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return followersInfo(context,
                                                    state.profile.followers, 'Seguidores');
                                              },
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                state.profile.followers.length
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0xff242C71)),
                                              ),
                                              const Text(
                                                "Seguidores",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0xff242C71)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      expandedHeight: 410.0,
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(100),
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Color(0xff6EBCDF),
                                width: 2,
                              ),
                              bottom: BorderSide(
                                color: Color(0xff6EBCDF),
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            tabs: const [
                              Tab(
                                text: 'Publicaciones',
                              ),
                              // Tab(
                              //   text: 'Comentarios',
                              // ),
                            ],
                            labelColor: const Color(0xff242C71),
                            unselectedLabelColor: const Color(0xff6EBCDF),
                            indicatorColor: const Color(0xff242C71),
                            labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: TabBarView(controller: _tabController, children: [
                  if (state.profilePosts.isEmpty)
                    const Center(child: Text('Sin publicaciones'))
                  else
                    ListView.builder(
                      itemCount: state.profilePosts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final isLikedNotifier = ValueNotifier<bool>(state
                            .profilePosts[index].postLikes
                            .contains(useridvisit));
                        return PostProfileScreen(
                            state.profilePosts[index], isLikedNotifier);
                      },
                    ),
                  // const Center(child: Text('Sin comentarios'))
                ]));
          } else if (state is Error) {
            return Center(
              child:
                  Text(state.error, style: const TextStyle(color: Colors.red)),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }

  AlertDialog followersInfo(BuildContext context, dynamic followers, String text) {
    List<dynamic> followDataList = List.from(followers);

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const Divider(
              color: Color(0xff5D95D1),
              thickness: 1,
              height: 1,
            ),
            Column(
              children: followDataList.map(
                (userinfo) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: userLabel(userinfo),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Container userLabel(dynamic userinfo) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffE1FCFF),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            // offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(userinfo['pk']),
                      ),
                    );
                  },
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
                                  'https://${EnvKeys.serverURI}${userinfo['profile']}'),
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
                              '${userinfo['first_name']} ${userinfo['last_name']}',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${userinfo['username']}',
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
