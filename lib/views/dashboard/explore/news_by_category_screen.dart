import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/helper/app_images.dart';
import 'package:news_app/model/search_news_model.dart';

import '../../../api/api_calls.dart';
import '../../../helper/route_constant.dart';

class NewsByCategoryScreen extends StatelessWidget {
  final String category;
  const NewsByCategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: ApiCalls.searchNewsByCategory(category),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(color: Colors.red));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.news!.length,
                  itemBuilder: (context, index) {
                    SearchNews news = snapshot.data!.news![index];
                    return InkWell(
                      onTap: () {
                        GoRouter.of(context).pushNamed(
                            RouteConstant.newsDetailScreen,
                            extra: ["category$category$index", news]);
                      },
                      child: Hero(
                        tag: "category$category$index",
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
                                    fontSize: 18, fontWeight: FontWeight.w500)),
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
          }),
    );
  }
}
