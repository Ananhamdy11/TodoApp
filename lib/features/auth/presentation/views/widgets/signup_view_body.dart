import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/services/auth_services.dart';
import 'package:todo_app/core/utils/app_color.dart';
import 'package:todo_app/core/utils/validation.dart';
import 'package:todo_app/features/auth/presentation/manger/cubit/auth_cubit.dart';
import 'package:todo_app/features/auth/presentation/views/widgets/custom_button.dart';
import 'package:todo_app/features/auth/presentation/views/widgets/custom_text_field.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthServices()),

      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, '/signin');
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 20,
                    children: [
                      Image.asset(
                        "assets/images/Premium Photo _ 3d clipboard and pencil on pink background notepad icon 3d render illustration 1.png",
                      ),
                      Text(
                        "Welcome Back to DO IT",
                        style: TextStyle(
                          color: AppColor.primaryColor,

                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "create an account and Join us now!",
                        style: TextStyle(color: AppColor.primaryColor),
                      ),
                      SizedBox(height: 10.sp),
                      CustomTextField(
                        controller: emailController,
                        prefixIcon: Icon(Icons.email_outlined),
                        label: "E-mail",
                        keyboardType: TextInputType.emailAddress,
                        validator: Validation.validateEmail,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        prefixIcon: Icon(Icons.password),
                        label: "Passward",
                        keyboardType: TextInputType.visiblePassword,
                        validator: Validation.validatePassword,
                        secureText: true,
                      ),
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              title: "Sign Up",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().signUp(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                }
                              },
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account ?",
                            // style: TextStyle(color: AppColor.secondaryColor),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/signin');
                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: AppColor.secondryTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
