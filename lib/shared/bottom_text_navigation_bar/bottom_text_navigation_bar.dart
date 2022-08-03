import 'package:flutter/material.dart';

class BottomTextNavigationBar extends StatelessWidget {
  final String text;
  final Icon icon;
  final VoidCallback onTap;
  const BottomTextNavigationBar({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
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
          padding: MaterialStateProperty.all(EdgeInsets.only(bottom: padding)),
        ),
        icon: icon,
        label: Text(
          text,
        ),
      ),
    );
  }
}
