import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umair_liaqat/bloc/login_bloc/login_event.dart';
import 'package:umair_liaqat/bloc/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {}
}
