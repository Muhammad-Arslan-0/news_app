import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/helper/app_images.dart';
import 'package:news_app/helper/route_constant.dart';
import 'package:news_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/buttons/auth_social_button.dart';

class LandingAuthScreen extends StatelessWidget {
  const LandingAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: screenHeight * .7,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Join ABC News",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              height: 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                          child: Text(
                            "Follow local and international news on a daily basis with a just swipe",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.grey,
                                height: 1.2),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        AuthSocialButton(
                          logo: AppImages.googleLogo,
                          text: "Continue With Google",
                          onTap: () {
                            Provider.of<AuthProvider>(context, listen: false)
                                .signInWithGoogle(context);
                          },
                        ),
                        AuthSocialButton(
                          logo: AppImages.fbLogo,
                          text: "Continue With Facebook",
                          onTap: () {},
                        ),
                        AuthSocialButton(
                          logo: AppImages.emailLogo,
                          text: "Continue With your E-mail",
                          onTap: () {},
                        ),
                      ],
                    ),
                    RichText(
                        text: TextSpan(
                            text: "Have an Account?  ",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600),
                            children: [
                          TextSpan(
                              text: "Sign in",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  GoRouter.of(context)
                                      .pushNamed(RouteConstant.signInScreen);
                                },
                              style: TextStyle(color: Colors.red,fontSize: 20.sp))
                        ])),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * .02,
            left: screenWidth * .25,
            right: screenWidth * .25,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                SizedBox(height: 20),
                FittedBox(
                  child: Text(
                    "Swipe up to Continue as Guest",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
