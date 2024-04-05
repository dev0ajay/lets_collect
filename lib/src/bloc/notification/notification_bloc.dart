
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/notification/notification_response.dart';
import 'package:lets_collect/src/model/state_model.dart';

import '../../resources/api_providers/notification_providers.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationProvider notificationProvider;
  NotificationBloc({required this.notificationProvider}) : super(NotificationInitial()) {
    on<GetNotificationList>((event, emit) async{
      emit(NotificationLoading());
      final StateModel? stateModel = await notificationProvider.getNotificationData();
      if(stateModel is SuccessState) {
        emit(NotificationLoaded(notificationGetResponse: stateModel.value));
      }
      if(stateModel is ErrorState) {
        emit(NotificationErrorState(errorMsg: stateModel.msg));
      }
    });
  }
}
