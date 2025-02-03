import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_theme.dart';
import '../main.dart';

class WidgetUtils {
  static Future<bool> showExitPopUp(BuildContext context) async {
    return await showPopUp(context,
        title: "Confirmation",
        message: "Are you sure to exit the app?",
        sBtnLabel: "Exit",
        sBtnFunction: () => Navigator.of(context).pop(true),
        showBtnN: true);
  }

  static Future<bool> showPopUp(BuildContext context,
      {String? title,
      String? message,
      String? sBtnLabel,
      String? nBtnLabel,
      GestureTapCallback? sBtnFunction,
      GestureTapCallback? nBtnFunction,
      bool? showBtnN}) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          title ?? AppStrings.appName,
          textAlign: TextAlign.center,
          style: Theme.of(navigatorKey.currentContext!)
              .textTheme
              .headlineSmall!
              .copyWith(
                  fontWeight: FontWeight.w600, color: AppColors.textBlackColor),
        ),
        content: Text(
          message ?? "",
          textAlign: TextAlign.center,
          style: Theme.of(navigatorKey.currentContext!)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.w400),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: sBtnFunction ?? () => Navigator.of(context).pop(),
            child: Text(
              sBtnLabel ?? "OK",
              style: Theme.of(navigatorKey.currentContext!)
                  .textTheme
                  .titleSmall!
                  .copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.textBlackColor),
            ),
          ),
          showBtnN == true
              ? TextButton(
                  onPressed:
                      nBtnFunction ?? () => Navigator.of(context).pop(false),
                  child: Text(
                    nBtnLabel ?? "Cancel",
                    style: Theme.of(navigatorKey.currentContext!)
                        .textTheme
                        .titleSmall!
                        .copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.textBlackColor),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  static Widget errorWidget(String text, {String? image, Color? color}) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: <Widget>[
          // logo(),
          const Text(AppStrings.appName),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(navigatorKey.currentContext!)
                  .textTheme
                  .labelMedium!
                  .copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textBlackColor),
            ),
          ),
        ],
      ),
    );
  }

  static Widget logoWidget() {
    return Center(
      child: CircleAvatar(
        radius: 100,
        backgroundColor: AppColors.primaryColor,
        child: Text(
          AppStrings.appName[0],
          style: appTheme.textTheme.displayLarge?.copyWith(
            color: AppColors.buttonTextColor,
          ),
        ),
      ),
    );
  }

  static showLogoutPopUp(
    BuildContext context, {
    GestureTapCallback? sBtnFunction,
  }) async {
    return await showPopUp(context,
        title: "Confirmation",
        message: "Are you sure to Logout?",
        sBtnLabel: "Confirm",
        sBtnFunction: sBtnFunction,
        showBtnN: true);
  }
}
