import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/api/api_calls.dart';
import 'package:news_app/helper/app_images.dart';
import 'package:news_app/model/latest_news_model.dart';
import 'package:news_app/widgets/shimmers/list_view_shimmer.dart';

import '../../../helper/route_constant.dart';

class TrendingScreen extends StatelessWidget {
  const TrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: ApiCalls.getLatestNews(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return ListViewShimmer();
            } else {
              return
                ListView.builder(
                  itemCount: snapshot.data!.news!.length,
                  itemBuilder: (context, index) {
                    News news = snapshot.data!.news![index];
                    return InkWell(
                      onTap: () {
                        GoRouter.of(context).pushNamed(
                            RouteConstant.newsDetailScreen,
                            extra: ["trending$index", news]);
                      },
                      child: Hero(
                        tag: "trending$index",
                        child: Card(
                          child: ListTile(
                            leading: news.image != null && news.image != "None"
                                ? CircleAvatar(
                                    backgroundImage: NetworkImage(news.image!))
                                : CircleAvatar(
                                    backgroundImage:
                                        AssetImage(AppImages.splashBg)),
                            title: Text(news.title!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.sp, fontWeight: FontWeight.w500)),
                            subtitle: Text(news.description!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 13.sp)),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
