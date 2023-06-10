import 'package:dev_connect_app/env_keys.dart';
import 'package:dev_connect_app/features/post/presentation/bloc/post_bloc.dart';
import 'package:dev_connect_app/features/profile/domain/entities/profile_post.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostProfileScreen extends StatefulWidget {
  final ProfilePost profilePost;
  final ValueNotifier<bool> isLikedNotifier;
  const PostProfileScreen(this.profilePost, this.isLikedNotifier, {super.key});

  @override
  State<PostProfileScreen> createState() => _PostProfileScreenState();
}

class _PostProfileScreenState extends State<PostProfileScreen> {
  VideoPlayerController? _controller;
  int? useridvisit;

  @override
  void initState() {
    super.initState();
    getIDUserVisit();
    if (widget.profilePost.postMediaRUL.toString().contains('.mp4')) {
      String urlVideo = widget.profilePost.postMediaRUL.toString();
      String urlHttps = urlVideo.replaceFirst('http://', 'https://');
      _controller = VideoPlayerController.network(urlHttps)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  Future<void> getIDUserVisit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    useridvisit = prefs.getInt('id');
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  Widget buildPostMediaWidget(ProfilePost post) {
    if (post.postMediaRUL.toString() != "null") {
      if (post.postMediaRUL.toString().contains('.mp4')) {
        return Column(
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: _controller!.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _controller!.value.aspectRatio,
                              child: VideoPlayer(_controller!),
                            )
                          : const CircularProgressIndicator(),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _controller!.value.isPlaying
                              ? _controller!.pause()
                              : _controller!.play();
                        });
                      },
                      child: Icon(
                        _controller!.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      } else {
        return Image.network(post.postMediaRUL.toString());
      }
    }
    return Container(); // Otra opción por si no hay media disponible
  }

  @override
  Widget build(BuildContext context) {
    final likesCountNotifier =
        ValueNotifier<int>(widget.profilePost.postLikes.length);
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
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
                                      'https://${EnvKeys.serverURI}${widget.profilePost.userAuthor['user_profile']}'),
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
                                  '${widget.profilePost.userAuthor['first_name']} ${widget.profilePost.userAuthor['last_name']}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.profilePost.userAuthor['username'],
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
                        widget.profilePost.date,
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
                          widget.profilePost.description,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff6F707A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildPostMediaWidget(widget.profilePost),
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
                                  valueListenable: widget.isLikedNotifier,
                                  builder: (context, isLiked, child) {
                                    return Row(
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {
                                            context.read<PostBloc>().add(LikePost(postid: widget.profilePost.id, userid: useridvisit!));
                                            widget.isLikedNotifier.value =
                                                !isLiked;
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
                                          padding:
                                              const EdgeInsets.only(left: 2),
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
                                            child:
                                                ValueListenableBuilder<int>(
                                              valueListenable:
                                                  likesCountNotifier,
                                              builder: (context, likesCount,
                                                  child) {
                                                return Center(
                                                  child: Text(
                                                    likesCount.toString(),
                                                    style: const TextStyle(
                                                      color:
                                                          Color(0xff6EBCDF),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
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
      },
    );
  }
}
