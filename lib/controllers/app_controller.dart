import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/enums.dart';
import '../main.dart';
import '../repo/shared_preference_repository.dart';
import '../ui/pages/posts_screen.dart';
import 'auth_controller.dart';

class AppController with ChangeNotifier {
  PageState _pageState = PageState.initial;

  PageState get pageState => _pageState;

  set pageState(PageState newState) {
    _pageState = newState;
    notifyListeners();
  }

  Future<void> fetchAppDetails(BuildContext context) async {
    _pageState = PageState.loading;
    await checkUserToken();
  }

  Future<void> checkUserToken() async {
    await Future.delayed(const Duration(seconds: 3));
    String? token = await SharedPreferenceRepository.getToken();
    pageState = PageState.success;
    if (token.isNotEmpty == true) {
      Navigator.pushAndRemoveUntil(
          navigatorKey.currentContext!,
          MaterialPageRoute(
            builder: (context) => const PostsScreen(),
          ),
          (Route<dynamic> route) => false);
    } else {
      Provider.of<AuthController>(navigatorKey.currentContext!, listen: false)
          .loadLoginScreen();
    }
  }
}
