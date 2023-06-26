import 'package:dev_connect_app/env_keys.dart';
import 'package:dev_connect_app/features/post/domain/entities/post.dart';
import 'package:dev_connect_app/features/post/presentation/bloc/post_bloc.dart';
import 'package:dev_connect_app/features/post/presentation/pages/detail_post_screen.dart';
import 'package:dev_connect_app/features/profile/presentation/bloc/profile_bloc.dart'
    as profile_bloc;
import 'package:dev_connect_app/features/profile/presentation/pages/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PostScreen extends StatefulWidget {
  final Post profilePost;
  final ValueNotifier<bool> isLikedNotifier;
  const PostScreen(this.profilePost, this.isLikedNotifier, {super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  VideoPlayerController? _controller;
  int? useridvisit;

  @override
  void initState() {
    super.initState();
    getIDUserVisit();
    if (widget.profilePost.mediaURL.toString().contains('.mp4')) {
      String urlVideo = widget.profilePost.mediaURL.toString();
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

  Widget buildPostMediaWidget(Post post) {
    if (post.mediaURL.toString() != "null") {
      if (post.mediaURL.toString().contains('.mp4')) {
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
      } else if (post.mediaURL.toString().contains('.opus')) {
        final player = AudioCache();
        String urlAudio = widget.profilePost.mediaURL.toString();
        String urlHttps = urlAudio.replaceFirst('http://', 'https://');
        return TextButton(
          onPressed: () async {
            final player = AudioPlayer();
            await player.play(UrlSource(urlHttps));
          },
          child: const Icon(Icons.play_arrow),
        );
      } else {
        return Image.network(post.mediaURL.toString());
      }
    }
    return Container(); // Otra opción por si no hay media disponible
  }

  @override
  Widget build(BuildContext context) {
    final commentController = TextEditingController();
    final likesCountNotifier =
        ValueNotifier<int>(widget.profilePost.likes!.length);
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProfileScreen(widget.profilePost.author),
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
                      ),
                      Text(
                        widget.profilePost.date!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff6F707A),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPostScreen(widget.profilePost.id!),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        children: [
                          Text(
                            widget.profilePost.description!,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff6F707A),
                            ),
                          ),
                        ],
                      ),
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
                                            context.read<PostBloc>().add(
                                                LikePost(
                                                    postid:
                                                        widget.profilePost.id!,
                                                    userid: useridvisit!));
                                            widget.isLikedNotifier.value =
                                                !isLiked;
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
                                            child: ValueListenableBuilder<int>(
                                              valueListenable:
                                                  likesCountNotifier,
                                              builder:
                                                  (context, likesCount, child) {
                                                return Center(
                                                  child: Text(
                                                    likesCount.toString(),
                                                    style: const TextStyle(
                                                      color: Color(0xff6EBCDF),
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
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      contentPadding: const EdgeInsets.all(12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      content: commentLabel(
                                          context,
                                          commentController,
                                          widget.profilePost),
                                    );
                                  },
                                );
                              },
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

  SizedBox commentLabel(BuildContext context,
      TextEditingController commentController, Post profilePost) {
    context
        .read<profile_bloc.ProfileBloc>()
        .add(profile_bloc.GetProfile(userid: useridvisit!));
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
                                context.read<PostBloc>().add(CreateComment(
                                    postid: widget.profilePost.id!,
                                    userid: useridvisit!,
                                    description: commentText,
                                    date: formattedDate));
                                Navigator.pop(context);
                                context.read<PostBloc>().add(GetDetailPost(
                                    postid: widget.profilePost.id!));
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
                            child: const Text('Comentar'),
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
                          border: InputBorder.none, hintText: 'Comentar')),
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
