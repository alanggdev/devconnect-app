import 'package:flutter/material.dart';

class FollowPostsScreen extends StatefulWidget {
  const FollowPostsScreen({super.key});

  @override
  State<FollowPostsScreen> createState() => _FollowPostsScreenState();
}

class _FollowPostsScreenState extends State<FollowPostsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Seguidos'),
    );
  }
}