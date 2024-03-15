import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/resources/api_providers/profile_screen_provider.dart';

import '../../model/cms/point_calculation.dart';
part 'point_calculations_event.dart';
part 'point_calculations_state.dart';

class PointCalculationsBloc extends Bloc<PointCalculationsEvent, PointCalculationsState> {
  final ProfileDataProvider profileDataProvider;
  PointCalculationsBloc({required this.profileDataProvider}) : super(PointCalculationsInitial()) {
    on<GetPointCalculationsEvent>((event, emit) async{
      emit(PointCalculationsLoading());
      final StateModel? stateModel = await profileDataProvider.getPointCalculations();
      if(stateModel is SuccessState) {
        emit(PointCalculationsLoaded(
            pointCalculationsResponse: stateModel.value));
      }
    });
  }
}