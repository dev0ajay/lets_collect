part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  final HomeResponse homeResponse;
  const HomeLoaded({required this.homeResponse});
  @override
  List<Object> get props => [homeResponse];
}


class HomeErrorState extends HomeState {
  final String errorMsg;
  const HomeErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}