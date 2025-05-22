import 'package:equatable/equatable.dart';
import 'package:umair_liaqat/models/user_model.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final String? errorMessage;

  const LoginState({
    this.isLoading = false,
    this.errorMessage,
  });
  LoginState copyWith(
      {bool? isLoading, String? errorMessage, UserModel? userData}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
      ];
}

class LoginInitial extends LoginState {}
