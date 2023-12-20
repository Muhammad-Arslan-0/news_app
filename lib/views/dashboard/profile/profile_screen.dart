import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/helper/app_colors.dart';
import 'package:news_app/helper/app_images.dart';
import 'package:news_app/helper/route_constant.dart';
import 'package:news_app/main.dart';
import 'package:news_app/services/firebase_services.dart';
import 'package:news_app/widgets/buttons/app_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            AppImages.splashBg,
            fit: BoxFit.cover,
            height: screenHeight * .1,
            width: screenHeight * .1,
          ),
        ),
        SizedBox(height: 10),
        Column(
          children: [
            localUser!.isGuest!
                ? Column(
                    children: [
                      Text("Guest",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.sp)),
                      SizedBox(
                          width: screenWidth * .6,
                          child: AppButton(
                              text: "Login",
                              onPressed: () {
                                GoRouter.of(context)
                                    .pushNamed(RouteConstant.signInScreen);
                              }))
                    ],
                  )
                : FutureBuilder(
                    future:
                        FirebaseServices.getUserFromFirestore(localUser!.uID!),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child:
                                CircularProgressIndicator(color: Colors.red));
                      } else {
                        return Column(
                          children: [
                            Text(snapshot.data!.userName!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.sp)),
                            RichText(
                                text: TextSpan(
                                    text:
                                        "${snapshot.data!.emailAddress!.split("@").first} ",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.sp),
                                    children: [
                                  TextSpan(
                                      text:
                                          "@${snapshot.data!.emailAddress!.split("@").last}",
                                      style: TextStyle(color: Colors.red))
                                ])),
                          ],
                        );
                      }
                    }),
          ],
        ),
        SizedBox(height: 15),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Account settings",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
            )),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.authFieldBgColor,
            child: Icon(Icons.person_outline_outlined),
          ),
          title: Text(
            "Your Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Edit and view profile info"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 10,
                child: Text("1", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 5),
              Icon(Icons.arrow_forward_ios, size: 15)
            ],
          ),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "App settings",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
            )),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.authFieldBgColor,
            child: Icon(Icons.light_mode_outlined),
          ),
          title: Text(
            "Display preference",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Adjust your display"),
          trailing: Icon(Icons.arrow_forward_ios, size: 15),
        ),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.authFieldBgColor,
            child: Icon(Icons.notifications_outlined),
          ),
          title: Text(
            "Notification",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("On/Off your notification"),
          trailing: Icon(Icons.arrow_forward_ios, size: 15),
        ),
      ],
    );
  }
}
