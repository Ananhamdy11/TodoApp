import 'package:flutter/material.dart';

import 'package:todo_app/features/home/presentation/views/widgets/completed_listview.dart';
import 'package:todo_app/features/home/presentation/views/widgets/search_text_field.dart';

class DoneTasksViewBody extends StatelessWidget {
  const DoneTasksViewBody({super.key});

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
            "Completed Task List",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          CompletedListview(),
        ],
      ),
    );
  }
}
