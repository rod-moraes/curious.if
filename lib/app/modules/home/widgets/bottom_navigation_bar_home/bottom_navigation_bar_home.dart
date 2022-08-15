import 'package:flutter/material.dart';

class BottomNavigationBarHome extends StatefulWidget {
  final Function(BottomNavigationBarEnum) onTap;
  const BottomNavigationBarHome({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BottomNavigationBarHome> createState() =>
      _BottomNavigationBarHomeState();
}

enum BottomNavigationBarEnum {
  posts('/posts/'),
  trending('/trending'),
  explorer('/explorer'),
  account('/account'),
  createPage('/create_post');

  final String route;
  const BottomNavigationBarEnum(this.route);
}

class _BottomNavigationBarHomeState extends State<BottomNavigationBarHome> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      onTap: (index) {
        currentIndex = index;
        final navigatorBarEnum = BottomNavigationBarEnum.values[index];
        widget.onTap(navigatorBarEnum);
        setState(() {});
      },
      selectedItemColor: Theme.of(context).colorScheme.primary,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_sharp,
            size: 34,
          ),
          label: "Postagens",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.rocket_launch_rounded,
            size: 34,
          ),
          label: "Em alta",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            size: 34,
          ),
          label: "Pesquisa",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle,
            size: 34,
          ),
          label: "Conta",
        ),
      ],
    );
  }
}
