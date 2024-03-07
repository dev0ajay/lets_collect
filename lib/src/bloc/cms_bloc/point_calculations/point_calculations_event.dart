part of 'point_calculations_bloc.dart';

abstract class PointCalculationsEvent extends Equatable {
  const PointCalculationsEvent();
}

class GetPointCalculationsEvent extends PointCalculationsEvent {
  @override
  List<Object?> get props => [];

}