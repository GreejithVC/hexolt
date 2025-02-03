import 'package:hexolt/ui/pages/splash_screen.dart';
import 'constants/app_theme.dart';
import 'controllers/app_controller.dart';
import 'controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/posts_controller.dart';

void main() async {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (final _) => AppController()),
        ChangeNotifierProvider(create: (final _) => AuthController()),
        ChangeNotifierProvider(create: (final _) => PostsController()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
