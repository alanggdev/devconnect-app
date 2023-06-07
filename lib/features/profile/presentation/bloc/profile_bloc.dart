import 'package:dev_connect_app/features/profile/domain/entities/profile.dart';
import 'package:dev_connect_app/features/profile/domain/usecases/get_own_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetOwnProfileUseCase getOwnProfileUseCase;

  ProfileBloc({required this.getOwnProfileUseCase}) : super(InitialState()) {
    on<ProfileEvent>((event, emit) async {
      if (event is GetOwnProfile) {
        try {
          emit(LoadingProfile());
          Profile profile = await getOwnProfileUseCase.execute();
          emit(LoadedProfile(profile: profile));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}