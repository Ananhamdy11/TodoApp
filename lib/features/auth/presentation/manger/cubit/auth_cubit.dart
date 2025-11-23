import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/services/auth_services.dart';
import 'package:todo_app/features/auth/data/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authServices) : super(AuthInitial());

  final AuthServices authServices;

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final user = await authServices.signIn(email: email, password: password);
      if (user != null) {
        final userModel = UserModel(id: user.uid, email: user.email ?? '');

        emit(AuthSuccess(userModel));
      } else {
        emit(AuthError('Sign in failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final user = await authServices.signUp(email: email, password: password);
      if (user != null) {
        final userModel = UserModel(id: user.uid, email: user.email ?? '');

        emit(AuthSuccess(userModel));
      } else {
        emit(AuthError('Sign up failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> logout(BuildContext context) async {
    await authServices.signOut();
    Navigator.pushReplacementNamed(context, '/signin');
  }
}
