import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_color.dart';
import 'package:todo_app/features/home/data/models/todo_model.dart';
import 'package:todo_app/features/home/presentation/manager/cubit/todos_cubit.dart';
import 'package:todo_app/features/home/presentation/views/widgets/search_text_field.dart';

class ModalBottomSheet extends StatefulWidget {
  const ModalBottomSheet({super.key});

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  Future<void> pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SearchTextField(
              text: "Title",
              prefixIcon: Icon(Icons.task),
              controller: titleController,
            ),
            SizedBox(height: 20.h),
            SearchTextField(
              text: "Description",
              lines: 5,
              controller: descController,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100.w,
                  child: FloatingActionButton(
                    onPressed: pickDate,
                    backgroundColor: AppColor.primaryColor,
                    foregroundColor: AppColor.secondaryColor,
                    child: Text("Date"),
                  ),
                ),
                SizedBox(width: 20.w),
                SizedBox(
                  width: 100.w,
                  child: FloatingActionButton(
                    onPressed: pickTime,
                    backgroundColor: AppColor.primaryColor,
                    foregroundColor: AppColor.secondaryColor,
                    child: Text("Time"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120.w,
                  child: FloatingActionButton(
                    backgroundColor: AppColor.secondaryColor,
                    foregroundColor: AppColor.primaryColor,
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                  ),
                ),
                SizedBox(width: 20.w),
                SizedBox(
                  width: 120.w,
                  child: FloatingActionButton(
                    backgroundColor: AppColor.secondryTextColor,
                    foregroundColor: AppColor.primaryColor,
                    onPressed: () {
                      if (titleController.text.isEmpty) return;

                      final now = DateTime.now();
                      final todo = TodoModel(
                        id: "",
                        title: titleController.text.trim(),
                        description: descController.text.trim(),
                        date: selectedDate != null
                            ? "${selectedDate!.day.toString().padLeft(2, '0')}/"
                                  "${selectedDate!.month.toString().padLeft(2, '0')}/"
                                  "${selectedDate!.year}"
                            : "${now.day.toString().padLeft(2, '0')}/"
                                  "${now.month.toString().padLeft(2, '0')}/"
                                  "${now.year}",
                        time: selectedTime != null
                            ? "${selectedTime!.hour.toString().padLeft(2, '0')}:"
                                  "${selectedTime!.minute.toString().padLeft(2, '0')}"
                            : "${now.hour.toString().padLeft(2, '0')}:"
                                  "${now.minute.toString().padLeft(2, '0')}",
                        done: false,
                      );

                      context.read<TodosCubit>().addTodo(todo);
                      Navigator.pop(context);
                    },
                    child: Text("Create"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
