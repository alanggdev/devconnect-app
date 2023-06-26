import 'package:dev_connect_app/features/post/presentation/bloc/post_bloc.dart';
import 'package:dev_connect_app/features/post/presentation/pages/comment_screen.dart';
import 'package:dev_connect_app/features/post/presentation/pages/post_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPostScreen extends StatefulWidget {
  final int postid;
  const DetailPostScreen(this.postid, {super.key});

  @override
  State<DetailPostScreen> createState() => _DetailPostScreenState();
}

class _DetailPostScreenState extends State<DetailPostScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int>? _userid;

  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(GetDetailPost(postid: widget.postid));
    _userid = _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('id') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar: AppBar(
        elevation: 2,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffF4F4F4),
        title: GestureDetector(
          onTap: () {
            Navigator.pop(context);
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
                    .read<PostBloc>()
                    .add(GetDetailPost(postid: widget.postid));
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is LoadingDetailPost) {
            return Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is LoadedDetailPost) {
            return FutureBuilder<int>(
                future: _userid,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
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
                        final isLikedNotifier = ValueNotifier<bool>(
                            state.post.likes!.contains(snapshot.data));
                        return Column(
                          children: [
                            PostScreen(state.post, isLikedNotifier),
                            if (state.comments.isEmpty)
                              const Text('Publicación sin comentarios')
                            else
                              Column(
                                children: state.comments.map((comment) {
                                  return CommentScreen(comment);
                                }).toList(),
                              ),
                          ],
                        );
                      }
                  }
                });
          } else if (state is Error) {
            return Center(
              child:
                  Text(state.error, style: const TextStyle(color: Colors.red)),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
