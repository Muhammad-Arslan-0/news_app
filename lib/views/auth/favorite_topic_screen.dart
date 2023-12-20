import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/helper/app_colors.dart';
import 'package:news_app/model/user_model.dart';
import 'package:news_app/providers/favorite_topic_provider.dart';
import 'package:news_app/widgets/buttons/app_button.dart';
import 'package:provider/provider.dart';

import '../../api/api_calls.dart';

class FavoriteTopicScreen extends StatelessWidget {
  final bool isFromGoogle;
  final UserModel userModel;
  const FavoriteTopicScreen(
      {super.key, required this.userModel, required this.isFromGoogle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Consumer<FavoriteTopicProvider>(
              builder: (context, provider, child) {
            return FutureBuilder(
                future: ApiCalls.getNewsCategories(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(color: Colors.red));
                  } else {
                    if (snapshot.data!.categories!.isEmpty) {
                      return Center(child: Text("No Category Found"));
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select your favorite topics",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28.sp),
                          ),
                          Text(
                            "Select some of your favorite topics to let us suggest better news for you.",
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                              child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 15,
                                          mainAxisSpacing: 15,
                                          childAspectRatio: 2,
                                          crossAxisCount: 2),
                                  itemCount: snapshot.data!.categories!.length,
                                  itemBuilder: (context, index) {
                                    String currentTopic =
                                        snapshot.data!.categories![index];
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: provider.selectedTopics
                                                  .contains(currentTopic)
                                              ? Colors.red
                                              : AppColors.authFieldBgColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          splashColor: Colors.red.shade200,
                                          highlightColor: Colors.transparent,
                                          splashFactory:
                                              InkSplash.splashFactory,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onTap: () {
                                            provider.selectTopic(currentTopic);
                                          },
                                          onLongPress: () {},
                                          child: Container(
                                            child: Center(
                                              child: Text(currentTopic,
                                                  style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color: provider
                                                            .selectedTopics
                                                            .contains(
                                                                currentTopic)
                                                        ? Colors.white
                                                        : Colors.red.shade400,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })),
                          Center(
                            child: AppButton(
                                text: "Next",
                                onPressed: provider.isLoading
                                    ? null
                                    : () {
                                        provider.submitTopics(
                                            userModel, context, isFromGoogle);
                                      }),
                          )
                        ],
                      );
                    }
                  }
                });
          }),
        ),
      ),
    );
  }
}
