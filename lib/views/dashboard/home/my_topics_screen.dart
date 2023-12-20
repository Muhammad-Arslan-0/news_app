import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/api/api_calls.dart';
import 'package:news_app/helper/app_images.dart';
import 'package:news_app/main.dart';
import 'package:news_app/services/firebase_services.dart';
import 'package:news_app/widgets/buttons/app_button.dart';
import 'package:news_app/widgets/shimmers/grid_view_shimmer.dart';

import '../../../helper/route_constant.dart';
import '../../../model/search_news_model.dart';

class MyTopicsScreen extends StatelessWidget {
  MyTopicsScreen({super.key});
  final List<String> listOfTopics = [
    "regional",
    "technology",
    "lifestyle",
    "business",
    "general",
    "programming",
    "science",
    "entertainment",
    "world",
    "sports",
    "finance",
    "academia",
    "politics",
    "health",
    "opinion",
    "food",
    "game",
    "fashion",
    "academic",
    "crap",
    "travel",
    "culture",
    "economy",
    "environment",
    "art",
    "music",
    "notsure",
    "CS",
    "education",
    "redundant",
    "television",
    "commodity",
    "movie",
    "entrepreneur",
    "review",
    "auto",
    "energy",
    "celebrity",
    "medical",
    "gadgets",
    "design",
    "EE",
    "security",
    "mobile",
    "estate",
    "funny"
  ];

  @override
  Widget build(BuildContext context) {
    return localUser!.isGuest!
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Please login first", style: TextStyle(fontSize: 20)),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: AppButton(
                    text: "Login",
                    onPressed: () {
                      GoRouter.of(context)
                          .pushNamed(RouteConstant.signInScreen);
                    }),
              )
            ],
          ))
        : FutureBuilder(
            future: FirebaseServices.getUserFromFirestore(localUser!.uID!),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return GridViewShimmer();
              } else {
                List fvTopics = [];
                if (snapshot.data!.fvTopics!.isEmpty) {
                  fvTopics = listOfTopics;
                } else {
                  fvTopics = snapshot.data!.fvTopics!;
                }
                return SingleChildScrollView(
                  child: Column(
                    children: fvTopics
                        .map((e) => FutureBuilder(
                            future: ApiCalls.searchNewsByCategory(e),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                    child: LinearProgressIndicator(
                                        color: Colors.red));
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          e.toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 25.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      GridView.builder(
                                          shrinkWrap: true,
                                          primary: false,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 10,
                                                  crossAxisSpacing: 10),
                                          itemCount: snapshot.data!.news!
                                              .take(10)
                                              .length,
                                          itemBuilder: (context, index) {
                                            SearchNews news =
                                                snapshot.data!.news![index];
                                            return GestureDetector(
                                              onTap: () {
                                                GoRouter.of(context).pushNamed(
                                                    RouteConstant
                                                        .newsDetailScreen,
                                                    extra: [
                                                      "myTopic$e$index",
                                                      news
                                                    ]);
                                              },
                                              child: Hero(
                                                tag: "myTopic$e$index",
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: GridTile(
                                                      footer: GridTileBar(
                                                        backgroundColor:
                                                            Colors.black54,
                                                        title: Text(
                                                          news.title!,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      child: news.image !=
                                                                  null &&
                                                              news.image !=
                                                                  "None"
                                                          ? Image.network(
                                                              news.image!,
                                                              fit: BoxFit.cover)
                                                          : Image.asset(
                                                              AppImages
                                                                  .splashBg,
                                                              fit:
                                                                  BoxFit.cover),
                                                    )),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                );
                              }
                            }))
                        .toList(),
                  ),
                );
              }
            });
  }
}
