part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}
class NotificationLoading extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationLoaded extends NotificationState {
  final NotificationGetResponse notificationGetResponse;
  const NotificationLoaded({required this.notificationGetResponse});
  @override
  List<Object> get props => [notificationGetResponse];
}

class NotificationErrorState extends NotificationState {
  final String errorMsg;
  const NotificationErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}