import 'package:flutter/material.dart';
import '../../../../../shared/shimmer_row/shimmer_row_widget.dart';

class PostShimmerWidget extends StatelessWidget {
  const PostShimmerWidget({
    Key? key,
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
        child: const ShimmerRowWidget(),
      ),
    );
  }
}
