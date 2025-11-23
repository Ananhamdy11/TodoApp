import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/app_color.dart';
import 'package:todo_app/features/home/data/models/todo_model.dart';
import 'package:todo_app/features/home/presentation/manager/cubit/todos_cubit.dart';

class TodoDetailsView extends StatelessWidget {
  final TodoModel todoModel;

  const TodoDetailsView({super.key, required this.todoModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Task Details",
            style: TextStyle(color: AppColor.secondaryColor),
          ),
          backgroundColor: AppColor.primaryColor,
          iconTheme: IconThemeData(color: AppColor.secondaryColor),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                spacing: 10,
                children: [
                  Text(
                    todoModel.title,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.edit_document),
                ],
              ),
              SizedBox(height: 30.h),

              Divider(height: 2.h),
              SizedBox(height: 30.h),
              Text(todoModel.description, style: TextStyle(fontSize: 16)),
              SizedBox(height: 30.h),
              Divider(height: 2.h),
              SizedBox(height: 30.h),

              Row(
                children: [
                  Icon(Icons.calendar_today, size: 20),
                  SizedBox(width: 8.w),
                  Text(todoModel.date, style: TextStyle(fontSize: 14)),
                  SizedBox(width: 20.w),
                  Divider(height: 2.h),

                  Icon(Icons.access_time, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(todoModel.time, style: TextStyle(fontSize: 14)),
                ],
              ),
              SizedBox(height: 16.h),
              Divider(height: 2.h),
              SizedBox(height: 16.h),

              Row(
                children: [
                  Text(
                    "Status: ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    todoModel.done ? "Completed" : "Uncompleted",
                    style: TextStyle(
                      fontSize: 16,
                      color: todoModel.done
                          ? Colors.green
                          : const Color.fromARGB(255, 239, 223, 46),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Divider(height: 2.h),
              SizedBox(height: 16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      if (todoModel.done) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("This task is already completed!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        return;
                      }

                      context.read<TodosCubit>().updateTodo(todoModel.id, {
                        "done": true,
                      });

                      Navigator.pop(context);
                    },

                    icon: Icon(Icons.check_circle, color: Colors.green),
                    label: Text(
                      "Mark as Done",
                      style: TextStyle(color: AppColor.secondaryColor),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: todoModel.done
                          ? Colors.grey.shade300
                          : AppColor.searchColor,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<TodosCubit>().removeTodo(todoModel.id);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                    label: Text(
                      "Delete",
                      style: TextStyle(color: AppColor.secondaryColor),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.searchColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
