import 'package:dev_connect_app/features/post/domain/usecases/create_post.dart';
import 'package:dev_connect_app/features/post/domain/usecases/get_following_posts.dart';
import 'package:dev_connect_app/features/post/domain/usecases/search_user.dart';
import 'package:dev_connect_app/features/profile/domain/usecases/update_profile.dart';
import 'package:dev_connect_app/features/session/data/datasources/session_remote.dart';
import 'package:dev_connect_app/features/profile/data/datasources/profile_remote.dart';
import 'package:dev_connect_app/features/post/data/datasources/post_remote.dart';

import 'package:dev_connect_app/features/session/data/repositories/session_repository_impl.dart';
import 'package:dev_connect_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:dev_connect_app/features/post/data/repositories/post_repository_impl.dart';

import 'package:dev_connect_app/features/session/domain/usecases/sign_in.dart';
import 'package:dev_connect_app/features/session/domain/usecases/sign_up.dart';
import 'package:dev_connect_app/features/profile/domain/usecases/get_profile.dart';
import 'package:dev_connect_app/features/profile/domain/usecases/get_profile_posts.dart';
import 'package:dev_connect_app/features/post/domain/usecases/update_post.dart';
import 'package:dev_connect_app/features/post/domain/usecases/get_all_posts.dart';
import 'package:dev_connect_app/features/post/domain/usecases/get_detail_post.dart';
import 'package:dev_connect_app/features/post/domain/usecases/get_post_comments.dart';
import 'package:dev_connect_app/features/post/domain/usecases/create_comment.dart';

class UseCaseConfig {
  SignInDatasourceImpl? signInDatasourceImpl;
  SignInRepositoryImpl? signInRepositoryImpl;
  SignInUseCase? signInUseCase;

  SignUpDatasourceImpl? signUpDatasourceImpl;
  SignUpRepositoryImpl? signUpRepositoryImpl;
  SignUpUseCase? signUpUseCase;

  ProfileDatasourceImp? profileDatasourceImp;
  ProfileRepositoryImpl? profileRepositoryImpl;
  GetProfileUseCase? getProfileUseCase;
  GetProfilePostsUseCase? getProfilePostsUseCase;
  UpdateProfileUseCase? updateProfileUseCase;

  PostDatasourceImpl? postDatasourceImpl;
  PostRepositoryImpl? postRepositoryImpl;
  UpdatePostUseCase? updatePostUseCase;
  GetAllPostsUseCase? getAllPostsUseCase;
  GetDetailPostUseCase? getDetailPostUseCase;
  GetPostCommentsUseCase? getPostCommentsUseCase;
  CreateCommentUseCase? createCommentUseCase;
  CreatePostUseCase? createPostUseCase;
  SearchUserUseCase? searchUserUseCase;
  GetFollowingPostsUseCase? getFollowingPostsUseCase;

  UseCaseConfig() {
    signInDatasourceImpl = SignInDatasourceImpl();
    signInRepositoryImpl = SignInRepositoryImpl(signInDatasource: signInDatasourceImpl!);
    signInUseCase = SignInUseCase(signInRepositoryImpl!);

    signUpDatasourceImpl = SignUpDatasourceImpl();
    signUpRepositoryImpl = SignUpRepositoryImpl(signUpDatasource: signUpDatasourceImpl!);
    signUpUseCase = SignUpUseCase(signUpRepositoryImpl!);

    profileDatasourceImp = ProfileDatasourceImp();
    profileRepositoryImpl = ProfileRepositoryImpl(profileDatasource: profileDatasourceImp!);
    getProfileUseCase = GetProfileUseCase(profileRepositoryImpl!);
    getProfilePostsUseCase = GetProfilePostsUseCase(profileRepositoryImpl!);
    updateProfileUseCase = UpdateProfileUseCase(profileRepositoryImpl!);

    postDatasourceImpl = PostDatasourceImpl();
    postRepositoryImpl = PostRepositoryImpl(postDatasource: postDatasourceImpl!);
    updatePostUseCase = UpdatePostUseCase(postRepositoryImpl!);
    getAllPostsUseCase = GetAllPostsUseCase(postRepositoryImpl!);
    getDetailPostUseCase = GetDetailPostUseCase(postRepositoryImpl!);
    getPostCommentsUseCase = GetPostCommentsUseCase(postRepositoryImpl!);
    createCommentUseCase = CreateCommentUseCase(postRepositoryImpl!);
    createPostUseCase = CreatePostUseCase(postRepositoryImpl!);
    searchUserUseCase = SearchUserUseCase(postRepositoryImpl!);
    getFollowingPostsUseCase = GetFollowingPostsUseCase(postRepositoryImpl!);
  }
}
