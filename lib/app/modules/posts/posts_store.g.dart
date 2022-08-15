// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PostsStore on _PostsStoreBase, Store {
  late final _$stateAtom =
      Atom(name: '_PostsStoreBase.state', context: context);

  @override
  PostsState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(PostsState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$loadingShimmerAtom =
      Atom(name: '_PostsStoreBase.loadingShimmer', context: context);

  @override
  int get loadingShimmer {
    _$loadingShimmerAtom.reportRead();
    return super.loadingShimmer;
  }

  @override
  set loadingShimmer(int value) {
    _$loadingShimmerAtom.reportWrite(value, super.loadingShimmer, () {
      super.loadingShimmer = value;
    });
  }

  late final _$_modifyPostsStateAsyncAction =
      AsyncAction('_PostsStoreBase._modifyPostsState', context: context);

  @override
  Future<void> _modifyPostsState(PostsState stateModify) {
    return _$_modifyPostsStateAsyncAction
        .run(() => super._modifyPostsState(stateModify));
  }

  late final _$listPostsAsyncAction =
      AsyncAction('_PostsStoreBase.listPosts', context: context);

  @override
  Future<void> listPosts({String? cursorID, String? id}) {
    return _$listPostsAsyncAction
        .run(() => super.listPosts(cursorID: cursorID, id: id));
  }

  late final _$_PostsStoreBaseActionController =
      ActionController(name: '_PostsStoreBase', context: context);

  @override
  void modifyShimmer(int length) {
    final _$actionInfo = _$_PostsStoreBaseActionController.startAction(
        name: '_PostsStoreBase.modifyShimmer');
    try {
      return super.modifyShimmer(length);
    } finally {
      _$_PostsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
loadingShimmer: ${loadingShimmer}
    ''';
  }
}
