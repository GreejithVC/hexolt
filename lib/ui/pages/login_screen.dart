import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_validators.dart';
import '../../constants/enums.dart';
import '../../controllers/auth_controller.dart';
import '../../main.dart';
import '../../utils/widgets/app_button.dart';
import '../../constants/app_strings.dart';
import '../../utils/widgets/app_textformfield.dart';
import '../../constants/app_theme.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController controller =
      Provider.of<AuthController>(navigatorKey.currentContext!, listen: false);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Form(
            key: _formKey,
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 100),
                  _titleView(),
                  const SizedBox(height: 20),
                  const Spacer(),
                  _emailView(),
                  const SizedBox(height: 16),
                  _passwordView(),
                  const Spacer(),
                  const SizedBox(height: 20),
                  _buttonView(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleView() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        AppStrings.appName,
        style: appTheme.textTheme.titleLarge,
      ),
    );
  }

  Widget _emailView() {
    return AppTextFormField(
      controller: controller.emailController,
      label: AppStrings.email,
      validator: AppValidators.email,
    );
  }

  Widget _passwordView() {
    return AppTextFormField(
      controller: controller.passwordController,
      label: AppStrings.password,
      validator: AppValidators.password,
    );
  }

  Widget _buttonView() {
    return Selector<AuthController, PageState>(
        selector: (buildContext, controller) => controller.pageState,
        builder: (context, data, child) {
          return AppButton(
              title: AppStrings.login,
              isLoading: data == PageState.loading,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  controller.signInWithEmailAndPassword();
                }
              });
        });
  }
}
