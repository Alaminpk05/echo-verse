import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({
    super.key,
    required this.navigationShell,
  });
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: (index) => navigationShell.goBranch(index),
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings), label: 'Settings'),
          ]),
    );
  }
}
