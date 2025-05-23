// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  final UserModel? userModel;
  const HomeState({
    this.userModel,
  });
  HomeState copyWith(
      {bool? isLoading, String? errorMessage, UserModel? userData}) {
    return HomeState(
      userModel: userData ?? userModel,
    );
  }

  @override
  List<Object?> get props => [userModel];
}

class HomeInitial extends HomeState {}

class AppBarHeadersIndexChanged extends HomeState {
  final int index;
  @override
  final UserModel? userModel;

  const AppBarHeadersIndexChanged(
    this.index,
    this.userModel,
  );

  @override
  List<Object?> get props => [index, userModel];
}

class AppBarHeadersAxisChanged extends HomeState {
  final AppBarHeadersAxis headersAxis;

  const AppBarHeadersAxisChanged(this.headersAxis);

  @override
  List<Object?> get props => [headersAxis];
}

class AppBarHeadersColorChangedByIndex extends HomeState {
  @override
  final UserModel? userModel;
  final int index;

  const AppBarHeadersColorChangedByIndex(
    this.index,
    this.userModel,
  );

  @override
  List<Object?> get props => [
        index,
        userModel,
      ];
}
