import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umair_liaqat/models/user_model.dart';
import 'package:umair_liaqat/repositories/user_repository.dart';
import 'package:umair_liaqat/utils/app_enum.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<ChangeAppBarHeadersIndex>(_changeAppBarHeadersIndex);
    on<ChangeAppBarHeadersAxis>(_changeAppBarHeadersAxis);
    on<ChangeAppBarHeadersColorByColor>(_changeAppBarHeadersColorByColor);
    on<GetUserData>(_getUserData);
  }
  int _appBarHeaderIndex = 0;
  final UserRepository userRepository = UserRepository();
  UserModel? userModel;
  int get appBarHeaderIndex => _appBarHeaderIndex;
  bool isLoading = false;

  FutureOr<void> _changeAppBarHeadersIndex(
    ChangeAppBarHeadersIndex event,
    Emitter<HomeState> emit,
  ) {
    _appBarHeaderIndex = event.index;
    emit(AppBarHeadersIndexChanged(
      _appBarHeaderIndex,
      state.userModel,
    ));
  }

  FutureOr<void> _changeAppBarHeadersColorByColor(
    ChangeAppBarHeadersColorByColor event,
    Emitter<HomeState> emit,
  ) {
    _appBarHeaderIndex = event.index;
    emit(
      AppBarHeadersColorChangedByIndex(
        _appBarHeaderIndex,
        state.userModel,
      ),
    );
  }

  //
  AppBarHeadersAxis _appBarHeaderAxis = AppBarHeadersAxis.horizontal;
  AppBarHeadersAxis get appBarHeaderAxis => _appBarHeaderAxis;

  FutureOr<void> _changeAppBarHeadersAxis(
    ChangeAppBarHeadersAxis event,
    Emitter<HomeState> emit,
  ) {
    _appBarHeaderAxis = event.headersAxis;

    emit(AppBarHeadersAxisChanged(_appBarHeaderAxis, state.userModel));
  }

  Future<void> _getUserData(GetUserData event, Emitter<HomeState> emit) async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );
      final user = await userRepository.getUserWithoutToken();
      if (user != null) {
        userModel = user;
        emit(
          state.copyWith(
            userData: userModel,
          ),
        );
      }
    } catch (e) {
      log("Error while fetching user information: ${e.toString()}");
    } finally {
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
    }
  }
}
