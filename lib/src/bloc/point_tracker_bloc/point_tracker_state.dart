part of 'point_tracker_bloc.dart';

@immutable
abstract class PointTrackerState extends Equatable{
  const PointTrackerState();
}

class PointTrackerInitial extends PointTrackerState {
  @override
  List<Object?> get props => [];
}

class PointTrackerLoading extends PointTrackerState {
  @override
  List<Object?> get props => [];
}

class PointTrackerLoaded extends PointTrackerState {
  final PointTrackerRequestResponse pointTrackerRequestResponse;
  const PointTrackerLoaded({required this.pointTrackerRequestResponse});
  @override
  List<Object?> get props => [];
}


///Point Tracker Details


class PointTrackerDetailsInitial extends PointTrackerState{
  @override
  List<Object?> get props => [];
}

class PointTrackerDetailsLoading extends PointTrackerState{
  @override
  List<Object?> get props => [];
}

class PointTrackerDetailsLoaded extends PointTrackerState{
  final PointTrackerDetailsRequestResponse pointTrackerDetailsRequestResponse;
  const PointTrackerDetailsLoaded({required this.pointTrackerDetailsRequestResponse});
  @override
  List<Object?> get props => [];
}