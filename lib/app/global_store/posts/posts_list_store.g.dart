// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PostsListStore on _PostsListStoreBase, Store {
  late final _$postsAtom =
      Atom(name: '_PostsListStoreBase.posts', context: context);

  @override
  ObservableList<PostModel> get posts {
    _$postsAtom.reportRead();
    return super.posts;
  }

  @override
  set posts(ObservableList<PostModel> value) {
    _$postsAtom.reportWrite(value, super.posts, () {
      super.posts = value;
    });
  }

  late final _$insertPostsAsyncAction =
      AsyncAction('_PostsListStoreBase.insertPosts', context: context);

  @override
  Future<void> insertPosts(List<PostModel> newPosts) {
    return _$insertPostsAsyncAction.run(() => super.insertPosts(newPosts));
  }

  late final _$removePostsAsyncAction =
      AsyncAction('_PostsListStoreBase.removePosts', context: context);

  @override
  Future<void> removePosts(List<String> removePosts) {
    return _$removePostsAsyncAction.run(() => super.removePosts(removePosts));
  }

  late final _$removePostAsyncAction =
      AsyncAction('_PostsListStoreBase.removePost', context: context);

  @override
  Future<void> removePost(String removePost) {
    return _$removePostAsyncAction.run(() => super.removePost(removePost));
  }

  @override
  String toString() {
    return '''
posts: ${posts}
    ''';
  }
}
