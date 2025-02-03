import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../constants/enums.dart';
import '../../controllers/app_controller.dart';
import '../../main.dart';
import '../../utils/widget_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppController _appProvider =
      Provider.of<AppController>(navigatorKey.currentContext!, listen: false);

  @override
  void initState() {
    super.initState();
    _appProvider.fetchAppDetails(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBodyWidget(context),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    return Selector<AppController, PageState>(
        selector: (buildContext, controller) => controller.pageState,
        builder: (context, data, child) {
          return data == PageState.error
              ? WidgetUtils.errorWidget("Something went wrong",
                  color: AppColors.textBlackColor)
              : WidgetUtils.logoWidget();
        });
  }
}
