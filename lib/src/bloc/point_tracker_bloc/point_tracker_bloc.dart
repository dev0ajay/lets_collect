import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/point_tracker/point_tracker_request.dart';
import 'package:lets_collect/src/model/point_tracker/point_tracker_response.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:meta/meta.dart';

import '../../model/point_tracker/point_tracker_details_request.dart';
import '../../model/point_tracker/point_tracker_details_response.dart';
import '../../resources/api_providers/purchase_data_provider.dart';

part 'point_tracker_event.dart';
part 'point_tracker_state.dart';

class PointTrackerBloc extends Bloc<PointTrackerEvent, PointTrackerState> {
  final PurchaseDataProvider pointTrackerProvider;
  PointTrackerBloc({required this.pointTrackerProvider}) : super(PointTrackerInitial()) {
    on<GetPointTrackerEvent>((event, emit) async {
      emit(PointTrackerLoading());
          final StateModel? stateModel =  await  pointTrackerProvider.pointTrackerRequest(event.pointTrackerRequest);
          if(stateModel is SuccessState){
            emit(PointTrackerLoaded(pointTrackerRequestResponse: stateModel.value));
          }
    });

    /// Point Tracker Details
    on<GetPointTrackerDetailEvent>((event, emit) async {
      emit(PointTrackerDetailsLoading());
      final StateModel? stateModel =  await  pointTrackerProvider.pointTrackerDetailsRequest(event.pointTrackerDetailsRequest);
      if(stateModel is SuccessState){
        emit(PointTrackerDetailsLoaded(pointTrackerDetailsRequestResponse: stateModel.value ));
      }
    });
  }
}
