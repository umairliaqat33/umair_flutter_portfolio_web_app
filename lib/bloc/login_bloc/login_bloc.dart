import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:umair_liaqat/bloc/login_bloc/login_event.dart';
import 'package:umair_liaqat/bloc/login_bloc/login_state.dart';
import 'package:umair_liaqat/ui/portfolio_details/portfolio_details_screen.dart';
import 'package:umair_liaqat/utils/collections.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<ChangeLoading>(_changeLoading);
    on<LoginButtonPressed>(onLoginButtonPressed);
  }
  bool _isLoading = false;
  FutureOr<void> _changeLoading(
    ChangeLoading event,
    Emitter<LoginState> emit,
  ) {
    _isLoading = event.isLoading;
    emit(
      state.copyWith(isLoading: _isLoading),
    );
  }

  Future<void> onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    try {
      final response = await Collections.supabase.auth.signInWithPassword(
        email: event.email,
        password: event.password,
      );

      if (response.user != null) {
        final context = event.context;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => PortfolioDetailsScreen(),
          ),
          (route) => false,
        );
      }
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
    } on AuthApiException catch (exception) {
      emit(state.copyWith(isLoading: false, errorMessage: "Unexpected error"));
      Fluttertoast.showToast(msg: exception.message);
      log("error while logging in: ${exception.message}");
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: "Unexpected error"));
      Fluttertoast.showToast(msg: e.toString());
      log("error while logging in: $e");
    }
  }
}
