import 'package:flutter/material.dart';
import 'package:news_app/providers/dashboard_provider.dart';
import 'package:news_app/widgets/my_app_bar.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * .07),
          child: MyAppBar(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: (index) {
            provider.changeIndex(index);
          },
          currentIndex: provider.currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined), label: "Explore"),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_fire_department_outlined),
                label: "Trending"),
            if (!localUser!.isGuest!)
              BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_outline), label: "Save"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: "Profile"),
          ],
        ),
        body:
            // provider.screens[provider.currentIndex]
            localUser!.isGuest!
                ? provider.screensWithOutSave[provider.currentIndex]
                : provider.screensWithSave[provider.currentIndex],
      );
    });
  }
}
