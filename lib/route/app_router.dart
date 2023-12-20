import 'package:go_router/go_router.dart';
import 'package:news_app/model/user_model.dart';
import 'package:news_app/views/auth/favorite_topic_screen.dart';
import 'package:news_app/views/auth/sign_in_screen.dart';
import 'package:news_app/views/auth/sign_up_screen.dart';
import 'package:news_app/views/dashboard/dashboard_screen.dart';
import 'package:news_app/views/dashboard/explore/news_by_category_screen.dart';
import 'package:news_app/views/dashboard/news_detail_screen.dart';
import 'package:news_app/views/on_board/on_board_screen.dart';
import 'package:news_app/views/splash_screen.dart';

import '../helper/route_constant.dart';

class AppRouter {
  static GoRouter router = GoRouter(routes: [
    GoRoute(
        path: "/",
        name: RouteConstant.splashScreen,
        builder: (context, state) {
          return SplashScreen();
        }),
    GoRoute(
        path: "/onBoard",
        name: RouteConstant.onBoardScreen,
        builder: (context, state) {
          return OnBoardScreen();
        }),
    GoRoute(
        path: "/dashBoard",
        name: RouteConstant.dashBoardScreen,
        builder: (context, state) {
          return DashBoardScreen();
        }),
    GoRoute(
        path: "/signIn",
        name: RouteConstant.signInScreen,
        builder: (context, state) {
          return SignInScreen();
        }),
    GoRoute(
        path: "/signUp",
        name: RouteConstant.signUpScreen,
        builder: (context, state) {
          return SignUpScreen();
        }),
    GoRoute(
        path: "/favTopic",
        name: RouteConstant.favoriteTopicScreen,
        builder: (context, state) {
          final data = state.extra as List;
          UserModel userModel = data.first;
          bool isFromGoogle = data.last;
          return FavoriteTopicScreen(
            userModel: userModel,
            isFromGoogle: isFromGoogle,
          );
        }),
    GoRoute(
        path: "/newsDetail",
        name: RouteConstant.newsDetailScreen,
        builder: (context, state) {
          List data = state.extra as List;
          return NewsDetailScreen(tag: data[0], news: data[1]);
        }),
    GoRoute(
        path: "/categoryNews",
        name: RouteConstant.categoryNewsScreen,
        builder: (context, state) {
          return NewsByCategoryScreen(category: state.extra as String);
        }),
  ]);
}
