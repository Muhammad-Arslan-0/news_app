import 'package:flutter/material.dart';
import 'package:news_app/api/api_calls.dart';
import 'package:news_app/main.dart';
import 'package:news_app/services/firebase_services.dart';
import 'package:news_app/widgets/shimmers/grid_view_shimmer.dart';

import '../../../helper/app_images.dart';
import '../../../widgets/shimmers/shimmer_widget.dart';

class SaveNewsScreen extends StatelessWidget {
  const SaveNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return FutureBuilder(
        future: FirebaseServices.getUserFromFirestore(localUser!.uID!),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return GridViewShimmer();
          } else {
            if (snapshot.data!.savedNews!.isEmpty) {
              return Center(child: Text("No Save news yet"));
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.builder(
                    primary: false,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10),
                    itemCount: snapshot.data!.savedNews!.length,
                    itemBuilder: (context, index) {
                      // String id = snapshot.data!.savedNews![index];
                      return FutureBuilder(
                          future: ApiCalls.getLatestNews(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Stack(
                                children: [
                                  ShimmerWidget(
                                    child: Container(
                                      height: screenHeight * .3,
                                      width: screenWidth,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: ShimmerWidget(
                                        isChild: true,
                                        child: Container(
                                            height: screenHeight * .06,
                                            width: screenWidth * .7,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                color: Colors.grey)),
                                      ))
                                ],
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  // GoRouter.of(context).pushNamed(
                                  //     RouteConstant.newsDetailScreen,
                                  //     extra: ["latestSaved$index", news]);
                                },
                                child: Hero(
                                  tag: "latestSaved$index",
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: GridTile(
                                        footer: GridTileBar(
                                          backgroundColor: Colors.black54,
                                          title: Text(
                                            "ABC",
                                            // news.title!,
                                            maxLines: 2,
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        child:
                                            // news.image != null &&
                                            //     news.image != "None"
                                            //     ? Image.network(news.image!,
                                            //     fit: BoxFit.cover)
                                            //     :
                                            Image.asset(AppImages.splashBg,
                                                fit: BoxFit.cover),
                                      )),
                                ),
                              );
                            }
                          });
                    }),
              );
            }
          }
        });
  }
}
