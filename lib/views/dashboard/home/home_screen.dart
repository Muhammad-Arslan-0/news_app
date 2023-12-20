import 'package:flutter/material.dart';
import 'package:news_app/views/dashboard/home/latest_news_screen.dart';
import 'package:news_app/views/dashboard/home/local_news_screen.dart';
import 'package:news_app/views/dashboard/home/my_topics_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
              dividerHeight: 0,
              indicatorColor: Colors.red,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: "Latest"),
                Tab(text: "My Topic"),
                Tab(text: "Local news"),
              ]),
          Expanded(
            child: TabBarView(children: [
              LatestNewsScreen(),
              MyTopicsScreen(),
              LocalNewsScreen(),
            ]),
          )
        ],
      ),
    );
  }
}
