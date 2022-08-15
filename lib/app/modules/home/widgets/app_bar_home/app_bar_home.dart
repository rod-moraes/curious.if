import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/core.dart';

class AppBarHome extends StatelessWidget with PreferredSizeWidget {
  final double statusBarHeight;
  final Function createPost;
  const AppBarHome({
    Key? key,
    required this.statusBarHeight,
    required this.createPost,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(statusBarHeight / 2 + 4.h);

  @override
  Widget build(BuildContext context) {
    final storeTheme = Modular.get<ThemeStore>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: storeTheme.colorStatus,
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          padding:
              EdgeInsets.only(top: statusBarHeight / 2, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppTheme.images.logoApp,
                height: 30,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => createPost(),
                    icon: const Icon(Icons.add_box),
                    iconSize: 28,
                    splashRadius: 24,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_none,
                    ),
                    iconSize: 28,
                    splashRadius: 24,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
