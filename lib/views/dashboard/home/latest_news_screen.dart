import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/api/api_calls.dart';
import 'package:news_app/main.dart';
import 'package:news_app/services/firebase_services.dart';
import 'package:news_app/widgets/shimmers/latest_news_shimmer.dart';

import '../../../helper/app_colors.dart';
import '../../../helper/app_images.dart';
import '../../../helper/route_constant.dart';
import '../../../model/latest_news_model.dart';
import '../../../widgets/toast.dart';

class LatestNewsScreen extends StatelessWidget {
  const LatestNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return FutureBuilder(
        future: ApiCalls.getLatestNews(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LatestNewsShimmer();
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: screenHeight * .5,
                      child: CarouselSlider.builder(
                          itemCount: snapshot.data!.news!.length,
                          itemBuilder: (context, index, i) {
                            News news = snapshot.data!.news![index];
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () {
                                  GoRouter.of(context).pushNamed(
                                      RouteConstant.newsDetailScreen,
                                      extra: ["detail$index", news]);
                                },
                                child: Hero(
                                  tag: "detail$index",
                                  child: Container(
                                    width: screenWidth * .8,
                                    child: Stack(
                                      children: [
                                        news.image != null &&
                                                news.image != "None"
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                    news.image!,
                                                    height: screenHeight,
                                                    width: screenWidth,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Center(
                                                            child: Icon(Icons
                                                                .warning_amber)),
                                                    fit: BoxFit.cover),
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.asset(
                                                    AppImages.splashBg,
                                                    width: screenWidth,
                                                    fit: BoxFit.cover),
                                              ),
                                        Container(
                                          height: screenHeight,
                                          width: screenWidth,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.black12),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Material(
                                                  type:
                                                      MaterialType.transparency,
                                                  child: Text(
                                                    news.title ??
                                                        "Social Security is rethinking how it runs customer service After Covid",
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 22.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                color: AppColors
                                                    .authFieldBgColor
                                                    .withOpacity(.8),
                                                child: ListTile(
                                                  title: Text(
                                                    news.author!.startsWith(
                                                                "<a") ||
                                                            news.author == null
                                                        ? "..."
                                                        : news.author!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 16.sp),
                                                  ),
                                                  trailing: Text(
                                                    GetTimeAgo.parse(
                                                            DateTime.parse(news
                                                                .published!))
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 16.sp),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        if (!localUser!.isGuest!)
                                          Positioned(
                                            right: 5,
                                            top: 5,
                                            child: IconButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            Colors.red)),
                                                color: Colors.white,
                                                onPressed: () {

                                                  FirebaseServices
                                                          .getUserFromFirestore(
                                                              localUser!.uID!)
                                                      .then((userModel) {
                                                        if(userModel!=null){
                                                          if (userModel.savedNews!
                                                              .contains(news.id)) {
                                                            userModel.savedNews!
                                                                .remove(news.id);
                                                            FirebaseFirestore.instance
                                                                .collection("users")
                                                                .doc(localUser!.uID!)
                                                                .update(userModel
                                                                .toJson());
                                                            toast(false,
                                                                "Removed from Bookmark");
                                                          } else
                                                          {
                                                            userModel.savedNews!
                                                                .add(news.id!);
                                                            FirebaseFirestore.instance
                                                                .collection("users")
                                                                .doc(localUser!.uID!)
                                                                .update(userModel
                                                                .toJson());
                                                            toast(false,
                                                                "Added to Bookmark");
                                                          }
                                                        }
                                                        else{
                                                          toast(true, "Something Went Wrong");
                                                        }

                                                  });
                                                },
                                                icon: Icon(
                                                    Icons.bookmark_outline)),
                                          )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                              autoPlay: true, height: screenHeight * .5))),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("Trending Topics",
                        style: TextStyle(
                            fontSize: 22.sp, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    height: screenHeight * .2,
                    child: ListView.builder(
                        itemCount: snapshot.data!.news!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          News news = snapshot.data!.news![index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                GoRouter.of(context).pushNamed(
                                    RouteConstant.newsDetailScreen,
                                    extra: ["trendingTopic$index", news]);
                              },
                              child: Hero(
                                tag: "trendingTopic$index",
                                child: Container(
                                  width: screenWidth * .45,
                                  decoration: BoxDecoration(
                                      image: news.image != null &&
                                              news.image != "None"
                                          ? DecorationImage(
                                              image: NetworkImage(news.image!),
                                              onError: (exception,
                                                      stackTrace) =>
                                                  Center(
                                                    child: Icon(
                                                        Icons.warning_amber),
                                                  ),
                                              fit: BoxFit.cover)
                                          : DecorationImage(
                                              image: AssetImage(
                                                  AppImages.splashBg),
                                              fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(10)),
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: screenWidth,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                      Colors.black12,
                                      Colors.grey.shade600
                                    ])),
                                    padding: EdgeInsets.all(10),
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: Text(
                                        news.category != null &&
                                                news.category!.isNotEmpty
                                            ? news.category!.first
                                            : "News",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            );
          }
        });
  }
}
