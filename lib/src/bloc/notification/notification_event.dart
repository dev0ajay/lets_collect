part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class GetNotificationList extends NotificationEvent{
  @override
  List<Object?> get props => [];
}