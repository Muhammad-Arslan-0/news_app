import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/helper/app_images.dart';
import 'package:news_app/helper/route_constant.dart';
import 'package:news_app/widgets/shimmers/local_news_shimmer.dart';

import '../../../api/api_calls.dart';
import '../../../model/search_news_model.dart';

class LocalNewsScreen extends StatelessWidget {
  const LocalNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return FutureBuilder(
        future: ApiCalls.searchNewsByCountry("pk"),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LocalNewsShimmer();
          } else {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.news!.length,
                itemBuilder: (context, index) {
                  SearchNews news = snapshot.data!.news![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        GoRouter.of(context).pushNamed(
                            RouteConstant.newsDetailScreen,
                            extra: ["localDetail$index", news]);
                      },
                      child: Hero(
                        tag: "localDetail$index",
                        child: Stack(
                          children: [
                            news.image != null || news.image != "None"
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(news.image!,
                                        height: screenHeight * .3,
                                        width: screenWidth,
                                        fit: BoxFit.cover))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(AppImages.splashBg,
                                        height: screenHeight * .3,
                                        width: screenWidth,
                                        fit: BoxFit.cover)),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        colors: [
                                          Colors.black54,
                                          Colors.transparent
                                        ])),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text(news.title ?? "news",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
        });
  }
}
