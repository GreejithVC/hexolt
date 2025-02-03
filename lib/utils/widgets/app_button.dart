import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.title,
    this.onTap,
    this.isLoading = false,
  });

  final String? title;
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(final BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        minimumSize: const Size(200, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: AppColors.buttonTextColor,
              ),
            )
          : Text(
              title ?? '',
              style: appTheme.textTheme.titleMedium
                  ?.copyWith(color: AppColors.buttonTextColor),
            ),
    );
  }
}
