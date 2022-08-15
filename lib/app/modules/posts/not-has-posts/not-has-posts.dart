import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sizer/sizer.dart';

import '../../../core/core.dart';

class NotHasPosts extends StatefulWidget {
  const NotHasPosts({Key? key}) : super(key: key);

  @override
  State<NotHasPosts> createState() => _NotHasPostsState();
}

class _NotHasPostsState extends State<NotHasPosts> {
  final storeTheme = Modular.get<ThemeStore>();
  late int numberCat;

  @override
  void initState() {
    numberCat = Random().nextInt(4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(height: 10.h),
          SizedBox(
            width: double.maxFinite,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Image.asset(
                AppTheme.images.cat(numberCat),
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Column(
            children: [
              Text(
                "Opa!",
                style: AppTheme.textStyles.headlineMediumSemiBold,
              ),
              const SizedBox(height: 16),
              Text(
                "Não encontramos nenhuma postagem",
                style: AppTheme.textStyles.labelMedium.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
