import 'dart:convert';

import '../../../core/core.dart';
import '../../../services/client/client_service.dart';
import '../model/post_model.dart';

abstract class IPostRepository {
  Future<List<PostModel>> listPosts({
    required String cursorID,
    required String takeValue,
    String? id,
  });
  Future<PostModel> createPost({
    required String token,
    required String to,
    required String content,
  });
  Future<void> likePost({
    required String token,
    required String id,
  });

  Future<void> removeLikePost({
    required String token,
    required String id,
  });
  void dispose();
}

class PostRepository implements IPostRepository {
  final ClientService _datasource;
  final String server = UtilsConst.server;

  PostRepository({required ClientService datasource})
      : _datasource = datasource;

  @override
  Future<List<PostModel>> listPosts({
    required String cursorID,
    required String takeValue,
    String? id,
  }) async {
    String? cursor = "cursor=$cursorID";
    String take = "take=$takeValue";
    try {
      final response = await _datasource.get(
        Uri.parse("${server}api/posts/?$cursor&$take"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'user_id': id ?? '',
        },
      );
      List<PostModel> posts = PostModel.fromJsonList(response);
      return posts;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PostModel> createPost({
    required String token,
    required String to,
    required String content,
  }) async {
    try {
      final response = await _datasource.post(Uri.parse("${server}api/posts/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(<String, String>{
            'content': content,
            'to': to,
          }));
      PostModel post = PostModel.fromJson(response);
      return post;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> likePost({
    required String token,
    required String id,
  }) async {
    try {
      await _datasource.post(
        Uri.parse("${server}api/posts/like/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeLikePost({
    required String token,
    required String id,
  }) async {
    try {
      await _datasource.delete(
        Uri.parse("${server}api/posts/like/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _datasource.dispose();
  }
}
