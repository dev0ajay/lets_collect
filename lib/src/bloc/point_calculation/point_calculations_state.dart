part of 'point_calculations_bloc.dart';

abstract class PointCalculationsState extends Equatable {
  const PointCalculationsState();
}

class PointCalculationsInitial extends PointCalculationsState {
  @override
  List<Object> get props => [];
}

class PointCalculationsLoading extends PointCalculationsState {
  @override
  List<Object> get props => [];
}

class PointCalculationsLoaded extends PointCalculationsState {
  final PointCalculationsResponse pointCalculationsResponse;
  const PointCalculationsLoaded({required this.pointCalculationsResponse});
  @override
  List<Object> get props => [pointCalculationsResponse];
}