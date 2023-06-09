import 'package:dev_connect_app/env_keys.dart';
import 'package:dev_connect_app/features/profile/domain/entities/profile_post.dart';
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
              print('Salir');
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
                      return postLabel(
                          state.profilePosts[index], isLikedNotifier);
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

  Padding postLabel(ProfilePost post, ValueNotifier<bool> isLikedNotifier) {
    final likesCountNotifier = ValueNotifier<int>(post.postLikes.length);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        // color: Colors.white,
        decoration: BoxDecoration(
          color: Colors.white,
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
          padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  'https://${EnvKeys.serverURI}${post.userAuthor['user_profile']}'),
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
                              '${post.userAuthor['first_name']} ${post.userAuthor['last_name']}',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              post.userAuthor['username'],
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
                  Text(
                    post.date,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff6F707A),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [
                    Text(
                      post.description,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff6F707A),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xff6EBCDF),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: isLikedNotifier,
                              builder: (context, isLiked, child) {
                                return Row(
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {
                                        isLikedNotifier.value = !isLiked;
                                        // print(isLikedNotifier.value);
                                        // print('changed');
                                        if (isLiked) {
                                          likesCountNotifier.value -= 1;
                                        } else {
                                          likesCountNotifier.value += 1;
                                        }
                                      },
                                      icon: Icon(
                                        isLiked
                                            ? Icons.thumb_up
                                            : Icons.thumb_up_outlined,
                                        color: isLiked
                                            ? const Color(0xff242C71)
                                            : const Color(0xff6EBCDF),
                                        size: 18,
                                      ),
                                      label: Text(
                                        'Me gusta',
                                        style: TextStyle(
                                            color: isLiked
                                                ? const Color(0xff242C71)
                                                : const Color(0xff6EBCDF),
                                            fontSize: 12,
                                            fontWeight: isLiked
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 2),
                                      child: Container(
                                        width: 15,
                                        height: 15,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.35),
                                              blurRadius: 5,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: ValueListenableBuilder<int>(
                                          valueListenable: likesCountNotifier,
                                          builder: (context, likesCount, child) {
                                            return Center(
                                          child: Text(
                                            likesCount.toString(),
                                            style: const TextStyle(
                                              color: Color(0xff6EBCDF),
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            // Row(
                            //   children: [
                            //     TextButton.icon(
                            //       onPressed: () {
                            //         print(isLiked);
                            //         if (isLiked) {
                            //           isLiked = false;
                            //         } else {
                            //           isLiked = true;
                            //         }
                            //         print(isLiked);
                            //         print('changed');
                            //       },
                            //       icon: Icon(
                            //         isLiked
                            //             ? Icons.thumb_up
                            //             : Icons.thumb_up_outlined,
                            //         color: isLiked
                            //             ? const Color(0xff242C71)
                            //             : const Color(0xff6EBCDF),
                            //         size: 18,
                            //       ),
                            //       label: Text(
                            //         'Me gusta',
                            //         style: TextStyle(
                            //             color: isLiked
                            //                 ? const Color(0xff242C71)
                            //                 : const Color(0xff6EBCDF),
                            //             fontSize: 12,
                            //             fontWeight: isLiked
                            //                 ? FontWeight.bold
                            //                 : FontWeight.normal),
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.only(left: 2),
                            //       child: Container(
                            //         width: 15,
                            //         height: 15,
                            //         decoration: BoxDecoration(
                            //           shape: BoxShape.circle,
                            //           color: Colors.white,
                            //           boxShadow: [
                            //             BoxShadow(
                            //               color: Colors.black.withOpacity(0.35),
                            //               blurRadius: 5,
                            //               offset: const Offset(0, 2),
                            //             ),
                            //           ],
                            //         ),
                            //         child: Center(
                            //           child: Text(
                            //             post.postLikes.length.toString(),
                            //             style: const TextStyle(
                            //               color: Color(0xff6EBCDF),
                            //               fontSize: 12,
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.chat_outlined,
                              color: Color(0xff6EBCDF), size: 18),
                          label: const Text(
                            'Comentar',
                            style: TextStyle(
                                color: Color(0xff6EBCDF), fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
