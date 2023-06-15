import 'package:flutter/material.dart';

class FollowPostsScreen extends StatefulWidget {
  const FollowPostsScreen({super.key});

  @override
  State<FollowPostsScreen> createState() => _FollowPostsScreenState();
}

class _FollowPostsScreenState extends State<FollowPostsScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // final searchController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(70),
            child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return AlertDialog(
                          contentPadding: const EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          content: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: TextField(
                                  controller: _controller,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  child: const Text('actualizar')),
                              Text(_controller.text),
                            ],
                          ),
                        );
                      });
                    },
                  );
                },
                child: const Text('open')),
          )
        ],
      ),
    );
  }
}
