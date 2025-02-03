import 'package:loadmore/loadmore.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/app_colors.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/posts_controller.dart';
import '../../constants/enums.dart';
import '../../main.dart';
import '../../models/post_model.dart';
import '../../utils/widget_utils.dart';
import '../components/post_tile.dart';
import '../components/shimmer_tile.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final PostsController controller =
      Provider.of<PostsController>(navigatorKey.currentContext!, listen: false);
  final AuthController authController =
      Provider.of<AuthController>(navigatorKey.currentContext!, listen: false);

  @override
  void initState() {
    super.initState();
    controller.initList();
  }

  @override
  Widget build(final BuildContext context) {
    return WillPopScope(
      onWillPop: () => WidgetUtils.showExitPopUp(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Posts'),
          actions: [
            IconButton(
                onPressed: authController.logoutAlertBox,
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Selector<PostsController, Tuple2<PageState, List<Post>>>(
          selector: (final context, final controller) =>
              Tuple2(controller.pageState, controller.posts),
          shouldRebuild: (Tuple2<PageState, List<Post>> before,
              Tuple2<PageState, List<Post>> after) {
            return true;
          },
          builder: (final context, final data, final child) {
            if (data.item1 == PageState.loading) {
              return _loadingView();
            } else if (data.item2.isNotEmpty) {
              return _postsListView();
            } else {
              return _errorView();
            }
          },
        ),
      ),
    );
  }

  Widget _postsListView() {
    return LoadMore(
      isFinish: controller.posts.length >= controller.totalCount,
      onLoadMore: controller.loadMore,
      textBuilder: DefaultLoadMoreTextBuilder.english,
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: controller.posts.length,
        itemBuilder: (final context, final index) {
          return PostTile(post: controller.posts[index]);
        },
        separatorBuilder: (final context, final index) {
          return const SizedBox(height: 12);
        },
      ),
    );
  }

  Widget _loadingView() {
    return Shimmer.fromColors(
      baseColor: AppColors.greyColor,
      highlightColor: AppColors.bgColor,
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: 10,
        itemBuilder: (final context, final index) {
          return const ShimmerTile();
        },
        separatorBuilder: (final context, final index) {
          return const SizedBox(height: 12);
        },
      ),
    );
  }

  Widget _errorView() {
    return Center(child: Text(controller.error ?? 'Unexpected error occured'));
  }
}
