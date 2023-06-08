import 'package:dev_connect_app/features/profile/domain/entities/profile.dart';
import 'package:dev_connect_app/features/profile/domain/usecases/get_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;

  ProfileBloc({required this.getProfileUseCase}) : super(InitialState()) {
    on<ProfileEvent>((event, emit) async {
      if (event is GetProfile) {
        try {
          emit(LoadingProfile());
          Profile profile = await getProfileUseCase.execute(event.userid);
          emit(LoadedProfile(profile: profile));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}