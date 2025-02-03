import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../constants/enums.dart';
import '../main.dart';
import '../repo/shared_preference_repository.dart';
import '../ui/pages/posts_screen.dart';
import '../ui/pages/login_screen.dart';
import '../utils/widget_utils.dart';

class AuthController with ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String? error;

  PageState _pageState = PageState.loading;

  set pageState(final PageState value) {
    _pageState = value;
    notifyListeners();
  }

  PageState get pageState => _pageState;

  intiController() {
    _pageState = PageState.initial;
    emailController.clear();
    passwordController.clear();
    nameController.clear();
  }

  Future<void> signInWithEmailAndPassword() async {
    pageState = PageState.loading;
    loadPostScreen();
    pageState = PageState.success;
  }

  logoutAlertBox() {
    WidgetUtils.showLogoutPopUp(navigatorKey.currentContext!,
        sBtnFunction: () => signOut());
  }

  Future<void> signOut() async {
    await SharedPreferenceRepository.setToken("");
    loadLoginScreen();
  }

  loadPostScreen() async {
    var uuid = Uuid();
    await SharedPreferenceRepository.setToken(uuid.v4());
    Navigator.pushReplacement(
      navigatorKey.currentContext!,
      MaterialPageRoute(builder: (final context) => const PostsScreen()),
    );
  }

  void loadLoginScreen() {
    intiController();
    Navigator.pushAndRemoveUntil(
        navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (Route<dynamic> route) => false);
  }
}
