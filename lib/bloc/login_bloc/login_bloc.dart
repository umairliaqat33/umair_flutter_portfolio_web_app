import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:umair_liaqat/bloc/login_bloc/login_event.dart';
import 'package:umair_liaqat/bloc/login_bloc/login_state.dart';
import 'package:umair_liaqat/ui/portfolio_details/portfolio_details_screen.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<ChangeLoading>(_changeLoading);
    on<LoginButtonPressed>(onLoginButtonPressed);
  }
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
      if (userCredential.user != null) {
        final context = event.context;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => PortfolioDetailsScreen(),
          ),
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.message));
      Fluttertoast.showToast(msg: e.message ?? "");
      log("error while logging in: $e");
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: "Unexpected error"));
      Fluttertoast.showToast(msg: e.toString());
      log("error while logging in: $e");
    }
  }
}
