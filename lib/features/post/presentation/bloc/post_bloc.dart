import 'package:dev_connect_app/features/post/domain/entities/post.dart';
import 'package:dev_connect_app/features/post/domain/usecases/get_all_posts.dart';
import 'package:dev_connect_app/features/post/domain/usecases/update_post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final UpdatePostUseCase updatePostUseCase;
  final GetAllPostsUseCase getAllPostsUseCase;

  PostBloc({required this.updatePostUseCase, required this.getAllPostsUseCase}) : super(InitialState()) {
    on<PostEvent>((event, emit) async {
      if (event is LikePost) {
        try {
          // emit(UpdatingPost());
          await updatePostUseCase.execute(event.postid, event.userid);
          // emit(UpdatedPostByLike(status: status));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      } else if (event is GetPublicPosts) {
        try {
          emit(LoadingPublicPosts());
          List<Post> publicPosts = await getAllPostsUseCase.execute();
          emit(LoadedPublicPosts(publicPosts: publicPosts));
        } catch (e) {
          emit(Error(error: e.toString()));
        }
      }
    });
  }
}
