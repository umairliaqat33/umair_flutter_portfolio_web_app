import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:umair_liaqat/utils/app_enum.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<ChangeAppBarHeadersIndex>(_changeAppBarHeadersIndex);
    on<ChangeAppBarHeadersAxis>(_changeAppBarHeadersAxis);
    on<ChangeAppBarHeadersColorByColor>(_changeAppBarHeadersColorByColor);
    on<ChangeLoading>(_changeLoading);
  }
  int _appBarHeaderIndex = 0;
  bool _isLoading = false;
  int get appBarHeaderIndex => _appBarHeaderIndex;
  bool get buttonLoading => _isLoading;

  FutureOr<void> _changeAppBarHeadersIndex(
    ChangeAppBarHeadersIndex event,
    Emitter<HomeState> emit,
  ) {
    _appBarHeaderIndex = event.index;
    emit(AppBarHeadersIndexChanged(_appBarHeaderIndex));
  }

  FutureOr<void> _changeLoading(
    ChangeLoading event,
    Emitter<HomeState> emit,
  ) {
    _isLoading = !event.isLoading;
    emit(ChangeLoadingVal(_isLoading));
  }

  FutureOr<void> _changeAppBarHeadersColorByColor(
    ChangeAppBarHeadersColorByColor event,
    Emitter<HomeState> emit,
  ) {
    _appBarHeaderIndex = event.index;
    emit(AppBarHeadersColorChangedByIndex(_appBarHeaderIndex));
  }

  //
  AppBarHeadersAxis _appBarHeaderAxis = AppBarHeadersAxis.horizontal;
  AppBarHeadersAxis get appBarHeaderAxis => _appBarHeaderAxis;

  FutureOr<void> _changeAppBarHeadersAxis(
    ChangeAppBarHeadersAxis event,
    Emitter<HomeState> emit,
  ) {
    _appBarHeaderAxis = event.headersAxis;
    emit(AppBarHeadersAxisChanged(_appBarHeaderAxis));
  }
}
