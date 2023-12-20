import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/helper/route_constant.dart';
import 'package:news_app/main.dart';
import 'package:news_app/model/local_user_model.dart';
import 'package:news_app/services/shared_pref_services.dart';
import 'package:news_app/views/on_board/landing_auth_screen.dart';

import '../../helper/app_images.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  late PageController _horizontalPageController;
  late PageController _verticalPageController;
  List<String> images = [
    AppImages.ob1,
    AppImages.ob2,
    AppImages.ob3,
    AppImages.ob4,
    AppImages.ob5,
    AppImages.ob1,
    AppImages.ob2,
    AppImages.ob3,
    AppImages.ob4,
    AppImages.ob5,
    AppImages.ob1,
    AppImages.ob2,
    AppImages.ob3,
    AppImages.ob4,
    AppImages.ob5,
  ];

  ScrollController _scrollController = ScrollController();
  late Timer _timer;
  @override
  void initState() {
    _horizontalPageController = PageController(initialPage: 0);
    _verticalPageController = PageController(initialPage: 0);
    startScrolling();
    super.initState();
  }

  startScrolling() {
    _scrollController.addListener(() {
      if (_scrollController.offset >
          _scrollController.position.maxScrollExtent - 5) {
        _scrollController.jumpTo(0);
      }
    });
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      double currentScroll = _scrollController.offset;
      _scrollController.animateTo(currentScroll + 2,
          duration: Duration(milliseconds: 10), curve: Curves.ease);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.removeListener(() {});
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
        body: PageView(
      scrollDirection: Axis.vertical,
      onPageChanged: (index) {
        if (index == 1) {
          localUser = LocalUserModel(isGuest: true, uID: null);
          SharedPrefServices.setUserToPref(
              LocalUserModel(isGuest: true, uID: null));
          GoRouter.of(context).goNamed(RouteConstant.dashBoardScreen);
        }
      },
      children: [
        PageView(
          controller: _horizontalPageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index) {
            if (index == 0) {
              startScrolling();
            } else {
              _timer.cancel();
            }
          },
          children: [
            Stack(
              children: [
                // auto scroll grid
                SizedBox(
                    height: screenHeight * .45,
                    width: screenWidth,
                    child: Transform.scale(
                      scale: 1.5,
                      child: Transform.rotate(
                        angle: 45 / 360,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: _scrollController,
                          child: StaggeredGrid.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            children: images
                                .map(
                                  (e) => StaggeredGridTile.count(
                                    crossAxisCellCount: 1,
                                    mainAxisCellCount: 1,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.asset(
                                          e,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    )),

                // overlay
                Container(
                  height: screenHeight,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.black.withOpacity(.3),
                        Colors.white.withOpacity(.5),
                        Colors.white,
                        Colors.white,
                      ])),
                ),
                Positioned(
                  bottom: screenHeight * .02,
                  left: screenWidth * .05,
                  right: screenWidth * .05,
                  child: Container(
                    height: screenHeight * .4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Artificial Intelligence shows your interests",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              height: 1),
                        ),
                        Text(
                          "Follow local and international news on a daily basis with a just swipe",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.sp, color: Colors.grey, height: 1),
                        ),
                        Container(
                          height: 10,
                          width: screenWidth * .2,
                          child: LinearProgressIndicator(
                            color: Colors.red,
                            backgroundColor: Colors.grey.shade300,
                            value: .7,
                            borderRadius: BorderRadius.circular(10),

                            // valueColor: _animation,
                          ),
                        ),
                        Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red),
                            child: Center(
                              child: Icon(
                                Icons.arrow_upward,
                                color: Colors.white,
                              ),
                            )),
                        FittedBox(
                          child: Text(
                            "Swipe up to Continue as Guest",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            LandingAuthScreen()
          ],
        ),
        SizedBox()
      ],
      controller: _verticalPageController,
    ));
  }
}
