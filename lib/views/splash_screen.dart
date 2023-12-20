import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/helper/app_images.dart';
import 'package:news_app/helper/route_constant.dart';
import 'package:news_app/main.dart';
import 'package:news_app/model/local_user_model.dart';
import 'package:news_app/services/shared_pref_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getUserFromPref().then((value) {
      if (value != null) {
        localUser = value;
        Future.delayed(Duration(seconds: 2), () {
          GoRouter.of(context).goNamed(RouteConstant.dashBoardScreen);
        });
      } else {
        Future.delayed(Duration(seconds: 2), () {
          GoRouter.of(context).goNamed(RouteConstant.onBoardScreen);
        });
      }
    });
    super.initState();
  }

  Future<LocalUserModel?> getUserFromPref() async {
    LocalUserModel? data = await SharedPrefServices.getUserFromPref();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Image.asset(
                AppImages.splashBg,
                fit: BoxFit.cover,
              )),
          Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.white.withOpacity(.3),
                  Colors.white.withOpacity(.9),
                  Colors.white,
                  Colors.white,
                ])),
          ),
          Positioned(
              top: screenHeight * .25,
              bottom: screenHeight * .25,
              left: screenWidth * .25,
              right: screenWidth * .25,
              child: Image.asset(AppImages.logo)),
          Positioned(
              left: screenWidth * .25,
              right: screenWidth * .25,
              bottom: screenHeight * .15,
              child:
                  Center(child: CircularProgressIndicator(color: Colors.red)))
        ],
      ),
    );
  }
}
