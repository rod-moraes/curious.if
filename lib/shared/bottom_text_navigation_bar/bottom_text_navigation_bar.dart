import 'package:flutter/material.dart';

import '../../app/core/core.dart';

class BottomTextNavigationBar extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final IconData icon;
  final double size;
  const BottomTextNavigationBar({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.size = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding.bottom / 2;
    return SizedBox(
      width: double.maxFinite,
      height: padding + 60,
      child: TextButton.icon(
        onPressed: () => onTap(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Theme.of(context).colorScheme.surface,
          ),
          shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
          padding: MaterialStateProperty.all(EdgeInsets.only(bottom: padding)),
        ),
        icon: Icon(
          icon,
          size: size,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        label: Text(
          text,
          style: AppTheme.textStyles.labelMedium.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
