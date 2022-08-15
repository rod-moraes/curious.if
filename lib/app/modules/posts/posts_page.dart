import 'package:asuka/asuka.dart';
import 'package:curious_if/app/global_store/posts/posts_list_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sizer/sizer.dart';
import '../../core/core.dart';
import '../../global_store/user/user_store.dart';
import 'not-has-posts/not-has-posts.dart';
import 'posts_state.dart';
import 'posts_store.dart';
import 'widgets/post_widget/post_shimmer_widget.dart';
import 'widgets/post_widget/post_widget.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final user = Modular.get<UserStore>();
  final storePosts = Modular.get<PostsListStore>();
  final store = Modular.get<PostsStore>();
  final storeTheme = Modular.get<ThemeStore>();
  @override
  void initState() {
    if (storePosts.posts.isEmpty) {
      store.listPosts(id: user.userModel?.id);
    }
    store.autoRun();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool scrollInfoFunction(ScrollNotification scrollInfo) {
    if (store.posts.isNotEmpty) {
      if ((scrollInfo.metrics.pixels >
              (scrollInfo.metrics.maxScrollExtent - 10.h)) &&
          store.state is! PostsStateLoading &&
          !store.last) {
        store.listPosts(cursorID: store.posts.last.id);
      }
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    print(UserStore().isLogged);
    return Observer(builder: (context) {
      int itemCount = (store.posts.isEmpty &&
              store.last &&
              store.state is PostsStateSuccess)
          ? 1
          : store.posts.length + store.loadingShimmer;
      return NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) => scrollInfoFunction(scrollInfo),
        child: RefreshIndicator(
          onRefresh: () async {
            await store.refreshScroll(user.userModel?.id);
          },
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (store.posts.isEmpty &&
                  store.last &&
                  store.state is PostsStateSuccess) {
                return const NotHasPosts();
              } else if (index < store.posts.length) {
                return PostWidget(
                    post: store.posts[index],
                    onDenounce: () async {
                      if (user.userModel != null) {
                        await Future.delayed(
                          const Duration(seconds: 0),
                          () => Navigator.canPop(context),
                        );
                        Asuka.showDialog(
                          barrierColor: Colors.black54,
                          builder: (BuildContext dialogContext) {
                            return Container();
                          },
                        );
                      } else {}
                    },
                    onTapComment: () async {
                      dynamic response = await Asuka.showDialog(
                        barrierColor: Colors.black54,
                        builder: (BuildContext dialogContext) {
                          return Container();
                        },
                      );
                      if (response is int && response != 0) {
                        store.posts[index] = store.posts[index].copyWith(
                            numberOfComments:
                                store.posts[index].numberOfComments + response);
                      }
                    },
                    onTapLike: (isLiked) async {
                      if (user.userModel != null) {
                        return await store.likePost(
                          !isLiked,
                          store.posts[index],
                          user.userModel!.token,
                        );
                      }
                      return null;
                    });
              } else {
                return const PostShimmerWidget();
              }
            },
          ),
        ),
      );
    });
  }
}
