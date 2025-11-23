import 'package:flutter/material.dart';
import 'package:todo_app/features/auth/presentation/views/widgets/signin_view_body.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SigninViewBody());
  }
}
