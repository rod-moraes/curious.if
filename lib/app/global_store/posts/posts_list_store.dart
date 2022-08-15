import 'package:mobx/mobx.dart';

import '../../domain/post/model/post_model.dart';

part 'posts_list_store.g.dart';

class PostsListStore extends _PostsListStoreBase with _$PostsListStore {}

abstract class _PostsListStoreBase with Store {
  @observable
  ObservableList<PostModel> posts = ObservableList.of([]);

  bool last = false;

  @action
  Future<void> insertPosts(List<PostModel> newPosts) async {
    posts.insertAll(0, newPosts);
  }

  @action
  Future<void> removePosts(List<String> removePosts) async {
    for (String element in removePosts) {
      posts.removeWhere((elementRemove) => elementRemove.id == element);
    }
  }

  @action
  Future<void> removePost(String removePost) async {
    posts.removeWhere((elementRemove) => elementRemove.id == removePost);
  }
}
