import 'package:flutter/material.dart';
import 'package:news_app/widgets/shimmers/shimmer_widget.dart';

import '../../helper/app_colors.dart';

class LatestNewsShimmer extends StatelessWidget {
  const LatestNewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Container(
          //   height: screenHeight * .1,
          //   child: ShimmerWidget(
          //     child: ListView.builder(
          //         itemCount: 8,
          //         shrinkWrap: true,
          //         scrollDirection: Axis.horizontal,
          //         itemBuilder: (context, index) {
          //           return Padding(
          //             padding: const EdgeInsets.all(5.0),
          //             child: CircleAvatar(
          //                 radius: 30, backgroundColor: AppColors.shimmerBgColor),
          //           );
          //         }),
          //   ),
          // ),
          // Container(
          //   height: screenHeight * .07,
          //   child: ShimmerWidget(
          //     child: ListView.builder(
          //         itemCount: 5,
          //         shrinkWrap: true,
          //         scrollDirection: Axis.horizontal,
          //         itemBuilder: (context, index) {
          //           return Padding(
          //             padding: const EdgeInsets.all(5.0),
          //             child: Container(
          //               width: screenWidth * .2,
          //               decoration: BoxDecoration(
          //                   color: AppColors.shimmerBgColor,
          //                   borderRadius: BorderRadius.circular(10)),
          //             ),
          //           );
          //         }),
          //   ),
          // ),
          Container(
            height: screenHeight * .45,
            child: ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: screenWidth * .8,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ShimmerWidget(
                                isChild: true,
                                child: Container(
                                  height: screenHeight * .03,
                                  width: screenWidth * .7,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ShimmerWidget(
                                isChild: true,
                                child: Container(
                                  height: screenHeight * .03,
                                  width: screenWidth * .6,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ShimmerWidget(
                                isChild: true,
                                child: Container(
                                  height: screenHeight * .03,
                                  width: screenWidth * .7,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                            ShimmerWidget(
                              isChild: true,
                              child: ListTile(
                                leading: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.grey.shade400),
                                title: Container(
                                  height: screenHeight * .02,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.grey.shade100,
                              Colors.grey.shade100,
                              Colors.grey.shade50,
                            ]),
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ShimmerWidget(
              child: Container(
                height: screenHeight * .03,
                width: screenWidth * .5,
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          Container(
            height: screenHeight * .2,
            child: ShimmerWidget(
              child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: [
                          Container(
                            width: screenWidth * .5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.shimmerBgColor),
                          ),
                          Icon(Icons.photo, color: Colors.black)
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}
