import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/config/app_theme.dart';
import 'package:todo_app/core/cubit/theme_cubit.dart';
import 'package:todo_app/core/data/shared_prefernces.dart';
import 'package:todo_app/core/services/auth_services.dart';
import 'package:todo_app/features/auth/presentation/manger/cubit/auth_cubit.dart';
import 'package:todo_app/features/auth/presentation/views/signin_view.dart';
import 'package:todo_app/features/auth/presentation/views/signup_view.dart';
import 'package:todo_app/features/home/presentation/manager/cubit/todos_cubit.dart';
import 'package:todo_app/features/home/presentation/views/home_view.dart';
import 'package:todo_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:todo_app/features/splash/presentation/views/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MySharedPreferences().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TodosCubit(user!.uid)..fetchTodos(),
          ),
          BlocProvider(create: (context) => AuthCubit(AuthServices())),
          BlocProvider(
            create: (context) => ThemeCubit(MySharedPreferences())..loadTheme(),
          ),
        ],

        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) {
            return MaterialApp(
              title: 'ToDo App',
              debugShowCheckedModeBanner: false,
              home: const SplashView(),
              theme: AppTheme.lightTheme(),
              darkTheme: AppTheme.darkTheme(),
              themeMode: mode,
              routes: {
                '/onboarding': (context) => OnboardingView(),
                '/signin': (context) => SigninView(),
                '/signup': (context) => SignupView(),
                '/home': (context) => HomeView(),
              },
            );
          },
        ),
      ),
    );
  }
}
