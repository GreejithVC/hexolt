import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import '../constants/enums.dart';
import '../models/post_model.dart';
import '../repo/data_base.dart';
import '../services/posts_service.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class PostsController with ChangeNotifier {
  List<Post> posts = [];
  String? error;
  bool isLoadingMore = false;
  int totalCount = 100;
  int page = 1;

  PageState _pageState = PageState.loading;

  set pageState(final PageState value) {
    _pageState = value;
    notifyListeners();
  }

  PageState get pageState => _pageState;

  Future<bool> loadMore() async {
    if (totalCount > posts.length && isLoadingMore != true) {
      isLoadingMore = true;
      page++;
      return _fetchPosts();
    }
    return false;
  }

  initList() async {
    _pageState = PageState.loading;
    isLoadingMore = false;
    posts.clear();
    page = 1;
    _fetchPosts();
  }

  Future<bool> _fetchPosts() async {
    bool result = await InternetConnection().hasInternetAccess;
    debugPrint("InternetConnection result --- $result");
    if (result) {
      try {
        final response = await PostsService().fetchPosts(posts.length);
        for (var post in response) {
          await DB.instance.addData(data: post, tableName: "posts");
        }
        if (page == 1) {
          posts = response;
        } else {
          posts.addAll(response);
        }
        totalCount = 100;
        isLoadingMore = false;
        if (posts.isNotEmpty) {
          error = null;
          pageState = PageState.success;
        } else {
          error = 'No Data Available';
          pageState = PageState.error;
        }
        return true;
      } on SocketException {
        error = 'Network Issue';
        isLoadingMore = false;
        pageState = PageState.error;
        return false;
      } catch (e) {
        error = e.toString();
        isLoadingMore = false;
        pageState = PageState.error;
        return false;
      }
    } else {
      totalCount = await DB.instance.getTableCount("posts");
      posts.addAll(await DB.instance.getPaginatedDataList<Post>(
          param: 'posts',
          fromJson: (json) => Post.fromJson(json),
          skip: posts.length));
      isLoadingMore = false;
      if (posts.isNotEmpty) {
        error = null;
        pageState = PageState.success;
      } else {
        error = 'No Data Available';
        pageState = PageState.error;
      }
      return true;
    }
  }
}
