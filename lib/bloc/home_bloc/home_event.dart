part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeAppBarHeadersIndex extends HomeEvent {
  final int index;
  final UserModel? userModel;

  ChangeAppBarHeadersIndex(
    this.index,
    this.userModel,
  );

  @override
  List<Object?> get props => [
        index,
        userModel,
      ];
}

class ChangeAppBarHeadersAxis extends HomeEvent {
  final AppBarHeadersAxis headersAxis;
  final UserModel? userModel;

  ChangeAppBarHeadersAxis(this.headersAxis, this.userModel);

  @override
  List<Object?> get props => [
        headersAxis,
        userModel,
      ];
}

class ChangeAppBarHeadersColorByColor extends HomeEvent {
  final int index;

  ChangeAppBarHeadersColorByColor(this.index);

  @override
  List<Object?> get props => [index];
}

class GetUserData extends HomeEvent {
  GetUserData();

  @override
  List<Object?> get props => [];
}
