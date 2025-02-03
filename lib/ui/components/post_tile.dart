import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../models/post_model.dart';
import '../../constants/app_theme.dart';

class PostTile extends StatelessWidget {
  const PostTile({
    required this.post,
    super.key,
  });

  final Post post;

  @override
  Widget build(final BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      titleAlignment: ListTileTitleAlignment.titleHeight,
      tileColor: AppColors.tileColor,
      subtitle: _bodyView(),
      minVerticalPadding: 10,
      contentPadding: EdgeInsets.all(20),
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Text(
          post.title ?? "",
          style: appTheme.textTheme.titleMedium,
        ),
      ),
    );
  }




  Widget _bodyView() {
    return Text(
      post.body ?? '....',
      textAlign: TextAlign.start,
      style: appTheme.textTheme.bodyMedium,
    );
  }
}
