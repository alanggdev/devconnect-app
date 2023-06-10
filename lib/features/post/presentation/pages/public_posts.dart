import 'package:flutter/material.dart';

class PublicPostsScreen extends StatefulWidget {
  const PublicPostsScreen({super.key});

  @override
  State<PublicPostsScreen> createState() => _PublicPostsScreenState();
}

class _PublicPostsScreenState extends State<PublicPostsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff3B47B6),
        body: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                backgroundColor: const Color(0xff3B47B6),
                elevation: 3,
                toolbarHeight: 70,
                automaticallyImplyLeading: false,
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
                // actions: <Widget>[
                //   Padding(
                //     padding: const EdgeInsets.only(right: 10),
                //     child: IconButton(
                //       icon: const Icon(
                //         Icons.menu,
                //         // color: CustomColors.baseLightBlue,
                //         size: 26,
                //       ),
                //       tooltip: 'Menú',
                //       onPressed: () {},
                //     ),
                //   ),
                // ],
              ),
            ];
          },
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: const [
                          Icon(Icons.notes),
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
                  ],
                ),
              ),
            ),
          ),
        ),
        
      ),
    );
  }
}