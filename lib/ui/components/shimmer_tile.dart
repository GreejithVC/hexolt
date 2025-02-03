import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class ShimmerTile extends StatelessWidget {
  const ShimmerTile({super.key});

  @override
  Widget build(final BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      titleAlignment: ListTileTitleAlignment.titleHeight,
      tileColor: AppColors.tileColor,
      leading: _leadingIconView(),
      minVerticalPadding: 10,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _textView(),
          const SizedBox(height: 4),
          _textView(),
          const SizedBox(height: 4),
          _textView(),
          const SizedBox(height: 4),
          _textView(),
          const SizedBox(height: 4),
          _textView(),
          const SizedBox(height: 4),
          _textView(),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget _leadingIconView() {
    return const CircleAvatar(
      radius: 23,
      backgroundColor: AppColors.greyColor,
    );
  }

  Widget _textView() {
    return const ColoredBox(
      color: AppColors.greyColor,
      child: SizedBox(height: 6),
    );
  }
}
