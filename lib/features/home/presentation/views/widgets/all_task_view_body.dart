import 'package:flutter/material.dart';
import 'package:todo_app/core/data/shared_prefernces.dart';
import 'package:todo_app/features/home/presentation/views/widgets/search_text_field.dart';
import 'package:todo_app/features/home/presentation/views/widgets/tasks_listview.dart';

class AllTaskViewBody extends StatelessWidget {
  AllTaskViewBody({super.key});
  final MySharedPreferences preferences = MySharedPreferences();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchTextField(text: "Search", prefixIcon: Icon(Icons.search)),
          Text(
            "Task List",
            style: TextStyle(
              //
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          TasksListview(),
        ],
      ),
    );
  }
}
