import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/model/local_user_model.dart';
import 'package:news_app/providers/dashboard_provider.dart';
import 'package:news_app/providers/explore_provider.dart';
import 'package:news_app/providers/favorite_topic_provider.dart';
import 'package:news_app/providers/on_board_provider.dart';
import 'package:news_app/providers/auth_provider.dart';
import 'package:news_app/route/app_router.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

LocalUserModel? localUser;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent));
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => OnBoardProvider()),
              ChangeNotifierProvider(create: (_) => FavoriteTopicProvider()),
              ChangeNotifierProvider(create: (_) => AuthProvider()),
              ChangeNotifierProvider(create: (_) => DashboardProvider()),
              ChangeNotifierProvider(create: (_) => ExploreProvider()),
            ],
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'News App',
              theme: ThemeData(
                  primaryColor: Colors.red,
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                      color: Colors.white, scrolledUnderElevation: 0)),
              routerDelegate: AppRouter.router.routerDelegate,
              routeInformationProvider:
                  AppRouter.router.routeInformationProvider,
              routeInformationParser: AppRouter.router.routeInformationParser,
            ),
          );
        });
  }
}
