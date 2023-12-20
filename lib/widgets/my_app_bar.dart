import 'package:flutter/material.dart';
import 'package:news_app/helper/app_images.dart';
import 'package:news_app/main.dart';
import 'package:news_app/providers/explore_provider.dart';
import 'package:news_app/widgets/shimmers/shimmer_widget.dart';
import 'package:provider/provider.dart';

import '../helper/app_colors.dart';
import '../providers/dashboard_provider.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return AppBar(
        centerTitle: true,
        title: provider.isLoading
            ? ShimmerWidget(
                child: Container(
                  height: screenHeight * .04,
                  width: screenWidth * .4,
                  decoration: BoxDecoration(
                      color: AppColors.shimmerBgColor,
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            : provider.currentIndex == 1
                ? Container(
                    width: screenWidth * .8,
                    decoration: BoxDecoration(
                        color: AppColors.authFieldBgColor,
                        borderRadius: BorderRadius.circular(100)),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      onFieldSubmitted: (text) {
                        FocusScope.of(context).unfocus();
                        Provider.of<ExploreProvider>(context, listen: false)
                            .changeKeyword(text);
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          contentPadding: EdgeInsets.only(left: 15),
                          border: InputBorder.none,
                          hintText: "Topic, Media or journalist"),
                    ))
                : provider.currentIndex == 4 && !localUser!.isGuest!
                    ? Text("Profile")
                    : Image.asset(AppImages.logo, scale: 2),
        actions: provider.currentIndex == 4
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: provider.isLogoutLoading
                      ? Center(
                          child: CircularProgressIndicator(color: Colors.red))
                      : GestureDetector(
                          onTap: () {
                            provider.logOutBtnPressed(context);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Logout ",
                                  style: TextStyle(color: Colors.red)),
                              Icon(Icons.logout, color: Colors.red)
                            ],
                          ),
                        ),
                )
              ]
            : null,
      );
    });
  }
}
