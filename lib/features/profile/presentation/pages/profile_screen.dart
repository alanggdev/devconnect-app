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
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetProfile(userid: widget.userid));
    _tabController = TabController(length: 2, vsync: this);
    getIDUserVisit();
  }

  Future<void> getIDUserVisit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    useridvisit = prefs.getInt('id');
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
              // print('Salir');
              // Navigator.pop(context);
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
                                        fontSize: 18, color: Color(0xff3B47B6)),
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
                                        Column(
                                          children: const [
                                            Text(
                                              "999",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff242C71)),
                                            ),
                                            Text(
                                              "Seguidos",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff242C71)),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: const [
                                            Text(
                                              "999",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff242C71)),
                                            ),
                                            Text(
                                              "Seguidores",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff242C71)),
                                            ),
                                          ],
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
                              Tab(
                                text: 'Comentarios',
                              ),
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
                  ListView.builder(
                    itemCount: state.profilePosts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final isLikedNotifier = ValueNotifier<bool>(state
                          .profilePosts[index].postLikes
                          .contains(useridvisit));
                      return PostProfileScreen(
                          state.profilePosts[index], isLikedNotifier);
                      // return postLabel(
                      //     state.profilePosts[index], isLikedNotifier);
                    },
                  ),
                  const Text('data')
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
}
