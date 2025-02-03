import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_theme.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField(
      {super.key, this.controller, this.label, this.validator});

  final TextEditingController? controller;
  final String? label;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(final BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        label: Text(
          label ?? '',
          style: appTheme.textTheme.bodyMedium,
        ),
        fillColor: AppColors.buttonTextColor,
        filled: true,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
