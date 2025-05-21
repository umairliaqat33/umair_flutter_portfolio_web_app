import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeLoading extends LoginEvent {
  final bool isLoading;

  ChangeLoading(this.isLoading);

  @override
  List<Object?> get props => [isLoading];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  final BuildContext context;

  LoginButtonPressed({
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object?> get props => [email, password];
}
