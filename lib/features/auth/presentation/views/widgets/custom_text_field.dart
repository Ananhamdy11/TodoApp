import 'package:flutter/material.dart';
import 'package:todo_app/core/data/shared_prefernces.dart';
import 'package:todo_app/core/utils/app_color.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.controller,
    this.onsubmitted,
    required this.prefixIcon,
    required this.label,
    required this.keyboardType,
    this.validator,
    this.secureText = false,
  });
  final TextEditingController controller;
  final void Function(String)? onsubmitted;
  final Icon prefixIcon;
  final String label;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool secureText;
  final MySharedPreferences preferences = MySharedPreferences();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: secureText,
      style: TextStyle(
        color: preferences.getThemeIsDark()
            ? AppColor.secondaryColor
            : AppColor.primaryColor,
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelStyle: TextStyle(
          color: preferences.getThemeIsDark()
              ? AppColor.secondaryColor
              : AppColor.primaryColor,
        ),
        hintText: label,
        hintStyle: TextStyle(
          color: preferences.getThemeIsDark()
              ? AppColor.secondaryColor
              : AppColor.primaryColor,
        ),

        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 4,
            // color: AppColor.secondaryColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            // color: AppColor.secondaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
