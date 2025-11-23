import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/data/shared_prefernces.dart';
import 'package:todo_app/core/utils/app_color.dart';
import 'package:todo_app/features/home/presentation/manager/cubit/todos_cubit.dart';
import 'package:todo_app/features/home/presentation/views/todo_details.dart';

class TasksListview extends StatelessWidget {
  TasksListview({super.key});
  final MySharedPreferences preferences = MySharedPreferences();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosCubit, TodosState>(
      builder: (context, state) {
        if (state is TodosLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TodosFailure) {
          return Center(child: Text(state.message));
        } else if (state is TodosSuccess) {
          final todos = state.todos;
          if (todos.isNotEmpty) {
            return Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      title: Text(
                        todos[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 14),
                                  SizedBox(width: 5),
                                  Text(todos[index].time, style: TextStyle()),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 14),
                                  SizedBox(width: 5),
                                  Text(todos[index].date, style: TextStyle()),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TodoDetailsView(todoModel: todos[index]),
                            ),
                          );
                        },
                        icon: Icon(Icons.arrow_circle_right_sharp),
                        color: AppColor.secondryTextColor,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: Text("No Tasks Yet", style: TextStyle(fontSize: 24.sp)),
            );
          }
        } else {
          return Center(child: Text(state.toString()));
        }
      },
    );
  }
}
