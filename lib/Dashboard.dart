import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'Constant/Colors.dart';
import 'UI/Home.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  void _navigationBottomBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }
  final List<Widget>tabs = [
    home(),
    Text("data3"),
    Text("data3"),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: tabs[_currentIndex],
        bottomNavigationBar: ConvexAppBar.badge(
          const <int,dynamic>{3:'99+'},
          style: TabStyle.custom,
          backgroundColor: PrimaryColors(),
          items: <TabItem>[
            TabItem(icon: Icons.home,title: "Home"),
            TabItem(icon: Icons.person,title: "Profile"),
            TabItem(icon: Icons.settings,title: "Setting")
          ],
          onTap: (int i) => _navigationBottomBar(i),
        )
    );
  }
}
