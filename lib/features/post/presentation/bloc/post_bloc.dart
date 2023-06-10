import 'package:dev_connect_app/features/post/domain/usecases/update_post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final UpdatePostUseCase updatePostUseCase;

  PostBloc({required this.updatePostUseCase}) : super(InitialState()) {
    on<PostEvent>((event, emit) async {
      if (event is LikePost) {
        try {
          emit(UpdatingPost());
          String status = await updatePostUseCase.execute(event.postid, event.userid);
          emit(UpdatedPostByLike(status: status));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}
