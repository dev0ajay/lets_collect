part of 'point_tracker_bloc.dart';

@immutable
abstract class PointTrackerEvent extends Equatable{
  const PointTrackerEvent();
}


class GetPointTrackerEvent extends PointTrackerEvent{
  final PointTrackerRequest pointTrackerRequest;
  const GetPointTrackerEvent({required this.pointTrackerRequest});
  @override
  List<Object?> get props => [];
}

class GetPointTrackerDetailEvent extends PointTrackerEvent{
  final PointTrackerDetailsRequest pointTrackerDetailsRequest;
  const GetPointTrackerDetailEvent({required this.pointTrackerDetailsRequest});
  @override
  List<Object?> get props => [];
}