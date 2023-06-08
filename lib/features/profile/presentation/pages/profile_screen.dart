import 'package:dev_connect_app/env_keys.dart';
import 'package:dev_connect_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetOwnProfile());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
          return SingleChildScrollView(
            child: Column(
              children: [
                const Text('Profile ID'),
                Text(state.profile.id.toString()),
                const Text('Profile Avatar'),
                Image.network(state.profile.avatarURL),
                const Text('Profile Description'),
                Text(state.profile.description),
                const Text('Profile Status'),
                Text(state.profile.status),
                const Text('Profile User ID'),
                Text(state.profile.userId.toString()),
                const Text('Profile User Detail'),
                Text(state.profile.user.toString()),
              ],
            ),
          );
        } else if (state is Error) {
          return Center(
            child: Text(state.error, style: const TextStyle(color: Colors.red)),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
