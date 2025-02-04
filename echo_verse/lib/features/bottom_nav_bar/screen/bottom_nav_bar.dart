import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nav bar'),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.house)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings)),
            
            
            
            ])
            
            ,
    );
  }
}
