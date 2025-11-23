import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/cubit/theme_cubit.dart';
import 'package:todo_app/core/utils/app_color.dart';
import 'package:todo_app/features/auth/presentation/manger/cubit/auth_cubit.dart';
import 'package:todo_app/features/home/presentation/views/widgets/all_task_view_body.dart';
import 'package:todo_app/features/home/presentation/views/widgets/done_tasks_view_body.dart';
import 'package:todo_app/features/home/presentation/views/widgets/modal_bottom_sheet.dart';
import 'package:todo_app/features/home/presentation/views/widgets/uncompleted_tasks_view_body.dart';
import 'package:todo_app/features/home/presentation/manager/cubit/todos_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final user = FirebaseAuth.instance.currentUser;
  int selectedIndex = 0;
  final List<Widget> pages = [
    AllTaskViewBody(),
    DoneTasksViewBody(),
    UncompletedTasksViewBody(),
  ];
  void selectedItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => TodosCubit(user!.uid)..fetchTodos(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.primaryColor,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello !",
                      style: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      user?.email ?? "No User",
                      style: TextStyle(
                        color: AppColor.secondaryColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                  icon: const Icon(
                    Icons.light_mode,
                    color: AppColor.secondaryColor,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.secondaryColor,
                  ),
                  onPressed: () {
                    context.read<AuthCubit>().logout(context);
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(color: AppColor.searchColor),
                  ),
                ),
              ],
            ),
          ),
          body: pages[selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.task), label: "Tasks"),
              BottomNavigationBarItem(
                icon: Icon(Icons.task_alt),
                label: "Completed",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.highlight_off),
                label: "Uncompleted",
              ),
            ],
            currentIndex: selectedIndex,
            onTap: selectedItem,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) {
                  return Container(
                    height: 400.h,
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: ModalBottomSheet(),
                  );
                },
              );
            },
            shape: CircleBorder(),
            backgroundColor: AppColor.secondaryColor,
            foregroundColor: AppColor.searchColor,
            child: Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      ),
    );
  }
}
