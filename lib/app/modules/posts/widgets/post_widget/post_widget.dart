import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../../domain/post/model/post_model.dart';
import 'comments_button_widget.dart';
import 'like_button_widget.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;
  final Future<bool?> Function(bool) onTapLike;
  final Function() onTapComment;
  final Future<void> Function() onDenounce;
  const PostWidget({
    Key? key,
    required this.post,
    required this.onTapLike,
    required this.onTapComment,
    required this.onDenounce,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  Text(
                    "Spotted#${post.numberPost.toString().padLeft(4, '0')}",
                    style: AppTheme.textStyles.labelMediumBold,
                  ),
                  const SizedBox(height: 12),
                  if (post.forPeople.isNotEmpty) ...[
                    Text.rich(
                      TextSpan(
                          text: "Para: ",
                          style: AppTheme.textStyles.labelMedium.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          children: [
                            TextSpan(
                              text: post.forPeople,
                              style: AppTheme.textStyles.labelMedium.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                            )
                          ]),
                    ),
                  ],
                  const SizedBox(height: 6),
                  Text(post.content, style: AppTheme.textStyles.labelMedium),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      LikeButtonWidget(
                        isLiked: post.isLiked,
                        numberOfLikes: post.numberOfLikes,
                        onTap: onTapLike,
                      ),
                      const SizedBox(width: 8),
                      CommentButtonWidget(
                        onTap: onTapComment,
                        numberOfComments: post.numberOfComments,
                      )
                    ],
                  )
                ]),
          ],
        ),
      ),
    );
  }
}
