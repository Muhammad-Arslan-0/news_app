import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:news_app/helper/app_colors.dart';
import 'package:news_app/helper/app_images.dart';

class NewsDetailScreen extends StatefulWidget {
  final String tag;
  final dynamic news;
  const NewsDetailScreen({super.key, required this.tag, required this.news});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController fadeAnimationController;
  late AnimationController slideAnimationController;

  @override
  void initState() {
    fadeAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    slideAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    fadeAnimationController.forward();
    slideAnimationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    fadeAnimationController.dispose();
    slideAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Hero(
                  tag: widget.tag,
                  child: widget.news.image != null &&
                          widget.news.image != "None"
                      ? Image.network(
                          widget.news.image!,
                          height: screenHeight * .5,
                          width: screenWidth,
                          fit: BoxFit.cover,
                          // loadingBuilder: (context, child, loadingProgress) =>
                          //     Container(
                          //   height: screenHeight * .5,
                          //   child: Center(
                          //     child:
                          //         CircularProgressIndicator(color: Colors.red),
                          //   ),
                          // ),
                          errorBuilder: (context, error, stackTrace) => Center(
                            child: Container(
                                height: screenHeight * .5,
                                child: Icon(Icons.warning_amber)),
                          ),
                        )
                      : Image.asset(
                          AppImages.splashBg,
                          height: screenHeight * .5,
                          width: screenWidth,
                          fit: BoxFit.cover,
                        )),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: FloatingActionButton(
                backgroundColor: AppColors.authFieldBgColor.withOpacity(.8),
                onPressed: () {
                  GoRouter.of(context).pop();
                },
                child: Icon(Icons.arrow_back),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: screenHeight * .6,
              width: screenWidth,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          FadeTransition(
                              opacity: Tween<double>(begin: 0.0, end: 1)
                                  .animate(fadeAnimationController),
                              child: Text(
                                "${DateFormat.MMMM().format(DateTime.parse(widget.news.published!))} ${DateFormat.d().format(DateTime.parse(widget.news.published!))}, ${DateFormat.y().format(DateTime.parse(widget.news.published!))} .  ",
                                style: TextStyle(fontSize: 16.sp),
                              )),
                          Expanded(
                            child: SlideTransition(
                                position: Tween<Offset>(
                                        begin: Offset(0.5, 0),
                                        end: Offset(0, 0))
                                    .animate(slideAnimationController),
                                child: Text(
                                    widget.news.author!.startsWith("<a") ||
                                            widget.news.author == null
                                        ? "..."
                                        : widget.news.author!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(fontSize: 17.sp))),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      SlideTransition(
                        position: Tween<Offset>(
                                begin: Offset(0.5, 0), end: Offset(0, 0))
                            .animate(slideAnimationController),
                        child: Text(
                          widget.news.title!,
                          style: TextStyle(
                              fontSize: 22.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 15),
                      SlideTransition(
                        position: Tween<Offset>(
                                begin: Offset(0, .5), end: Offset(0, 0))
                            .animate(slideAnimationController),
                        child: Text(
                          widget.news.description ?? "",
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
