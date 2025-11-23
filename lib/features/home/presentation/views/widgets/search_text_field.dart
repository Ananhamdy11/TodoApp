import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/utils/app_color.dart';
import 'package:todo_app/features/home/presentation/manager/cubit/todos_cubit.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.text,
    this.prefixIcon,
    this.lines,
    this.controller,
  });
  final String text;
  final Icon? prefixIcon;
  final int? lines;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        keyboardType: TextInputType.text,
        maxLines: lines,
        controller: controller,
        style: TextStyle(color: AppColor.secondaryColor),
        onChanged: (value) {
          context.read<TodosCubit>().search(value);
        },
        decoration: InputDecoration(
          hintText: text,
          prefixIcon: prefixIcon,

          hintStyle: TextStyle(color: AppColor.secondaryColor),
          prefixIconColor: AppColor.secondaryColor,
          filled: true,

          fillColor: AppColor.searchColor,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 4,
              color: AppColor.secondaryColor,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.secondaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
