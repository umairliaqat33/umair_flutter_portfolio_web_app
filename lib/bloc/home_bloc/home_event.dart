part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangeAppBarHeadersIndex extends HomeEvent {
  final int index;

  ChangeAppBarHeadersIndex(this.index);

  @override
  List<Object?> get props => [index];
}

class ChangeLoading extends HomeEvent {
  final bool isLoading;

  ChangeLoading(this.isLoading);

  @override
  List<Object?> get props => [isLoading];
}

class ChangeAppBarHeadersAxis extends HomeEvent {
  final AppBarHeadersAxis headersAxis;

  ChangeAppBarHeadersAxis(this.headersAxis);

  @override
  List<Object?> get props => [headersAxis];
}

class ChangeAppBarHeadersColorByColor extends HomeEvent {
  final int index;

  ChangeAppBarHeadersColorByColor(this.index);

  @override
  List<Object?> get props => [index];
}
