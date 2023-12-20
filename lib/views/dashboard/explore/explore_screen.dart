import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/helper/app_images.dart';
import 'package:news_app/helper/route_constant.dart';
import 'package:news_app/model/search_news_model.dart';
import 'package:news_app/providers/explore_provider.dart';
import 'package:news_app/widgets/shimmers/categories_shimmer.dart';
import 'package:news_app/widgets/shimmers/list_view_shimmer.dart';
import 'package:provider/provider.dart';

import '../../../api/api_calls.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExploreProvider>(builder: (context, provider, child) {
      return provider.keyword.isNotEmpty
          ? FutureBuilder(
              future: ApiCalls.searchNewsByKeyword(provider.keyword),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return ListViewShimmer();
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.news!.length,
                      itemBuilder: (context, index) {
                        SearchNews news = snapshot.data!.news![index];
                        return InkWell(
                          onTap: () {
                            GoRouter.of(context).pushNamed(
                                RouteConstant.newsDetailScreen,
                                extra: ["search$index", news]);
                          },
                          child: Hero(
                            tag: "search$index",
                            child: Card(
                              child: ListTile(
                                leading:
                                    news.image != null && news.image != "None"
                                        ? CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(news.image!))
                                        : CircleAvatar(
                                            backgroundImage:
                                                AssetImage(AppImages.splashBg)),
                                title: Text(news.title!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                                subtitle: Text(news.description!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 15)),
                              ),
                            ),
                          ),
                        );
                      });
                }
              })
          : FutureBuilder(
              future: ApiCalls.getNewsCategories(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CategoriesShimmer();
                } else {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Explore by categories",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold),
                          ),
                          GridView.builder(
                              itemCount: snapshot.data!.categories!.length,
                              shrinkWrap: true,
                              primary: false,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5),
                              itemBuilder: (context, index) {
                                String category =
                                    snapshot.data!.categories![index];
                                return GestureDetector(
                                  onTap: () {
                                    GoRouter.of(context).pushNamed(
                                        RouteConstant.categoryNewsScreen,
                                        extra: category);
                                  },
                                  child: Container(
                                    child: Center(
                                      child: FittedBox(
                                        child: Text(
                                          category,
                                          style: TextStyle(
                                              fontSize: 20.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        gradient: RadialGradient(
                                            radius: .55,
                                            focal: Alignment.bottomCenter,
                                            colors: [
                                              Colors.white70,
                                              Colors.red
                                            ]),
                                        shape: BoxShape.circle),
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  );
                }
              });
    });
  }
}
