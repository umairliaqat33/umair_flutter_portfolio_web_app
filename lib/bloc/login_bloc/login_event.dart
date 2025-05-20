import 'package:equatable/equatable.dart';

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

  LoginButtonPressed(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}
