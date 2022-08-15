import 'dart:developer';
import 'package:curious_if/app/global_store/posts/posts_list_store.dart';
import 'package:mobx/mobx.dart';

import '../../domain/post/model/post_model.dart';
import '../../domain/post/usecase/post_usecase.dart';
import '../../domain/reports/model/report_post.dart';
import '../../domain/reports/usecase/reports_usecase.dart';
import 'posts_state.dart';

part 'posts_store.g.dart';

class PostsStore extends _PostsStoreBase with _$PostsStore {
  PostsStore({
    required IPostUseCase postUsecase,
    required IReportsUseCase reportUsecase,
    required PostsListStore storePosts,
  }) {
    _postUsecase = postUsecase;
    _reportUsecase = reportUsecase;
    _storePosts = storePosts;
  }
}

abstract class _PostsStoreBase with Store {
  late final IPostUseCase _postUsecase;
  late final IReportsUseCase _reportUsecase;
  late final PostsListStore _storePosts;

  late ReactionDisposer reactionDisposer;

  @observable
  PostsState state = PostsStateEmpty();

  List<PostModel> get posts => _storePosts.posts;

  @observable
  int loadingShimmer = 0;

  bool get last => _storePosts.last;

  @action
  void modifyShimmer(int length) => loadingShimmer = length;

  @action
  Future<void> _modifyPostsState(PostsState stateModify) async =>
      state = stateModify;

  @action
  Future<void> listPosts({String? cursorID, String? id}) async {
    try {
      modifyShimmer(5);
      await _modifyPostsState(PostsStateLoading());

      await Future.delayed(const Duration(seconds: 1));
      List<PostModel> posts =
          await _postUsecase.listPosts(cursorID: cursorID ?? '', id: id);
      if (cursorID == null) {
        _storePosts.last = false;
        _storePosts.posts.removeWhere((element) => true);
      }
      _storePosts.posts.addAll(posts);
      if (posts.isEmpty || posts.length < 10) _storePosts.last = true;
      await _modifyPostsState(PostsStateSuccess(
          message: "Posts buscados com sucesso", posts: posts));
    } catch (e) {
      await _modifyPostsState(PostsStateFailure(message: e.toString()));
    }
  }

  Future<void> refreshScroll(String? id) async {
    if ((state is! PostsStateLoading) || _storePosts.posts.isNotEmpty) {
      _storePosts.posts.removeWhere((element) => true);
      await listPosts(id: id);
    }
  }

  Future<bool?> likePost(bool isLiked, PostModel post, String token) async {
    try {
      await _postUsecase.setLikePost(
          isLiked: isLiked, id: post.id, token: token);
      return isLiked;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool> reportPost(PostModel post, String content, String token) async {
    try {
      ReportPost report = ReportPost(postId: post.id, content: content);
      await Future.delayed(const Duration(seconds: 2));
      await _reportUsecase.reportPost(report, token);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  void autoRun() {
    reactionDisposer = autorun((_) async {
      if (state is PostsStateFailure) {
        modifyShimmer(0);
        String message = (state as PostsStateFailure).message;
      } else if (state is PostsStateSuccess) {
        modifyShimmer(0);
      }
    });
  }

  void dispose() {}
}
