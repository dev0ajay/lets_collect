import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/redemption_history/redemption_history.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/resources/api_providers/redemption_history_provider.dart';
import 'package:meta/meta.dart';

part 'redemption_history_event.dart';
part 'redemption_history_state.dart';

// class RedemptionHistoryBloc extends Bloc<RedemptionHistoryEvent, RedemptionHistoryState> {
//   final RedemptionHistoryDataProvider redemptionDataProvider;
//   RedemptionHistoryBloc({required this.redemptionDataProvider}) : super(RedemptionHistoryInitial()) {
//     on<GetRedemptionHistory>((event, emit) async{
//       emit(RedemptionHistoryLoading());
//
//       final StateModel? stateModel = await redemptionDataProvider.getRedemptionData();
//       if(stateModel is SuccessState) {
//         emit(RedemptionHistoryLoaded(redemptionHistoryResponse: stateModel.value));
//       }
//     });
//   }
// }


class RedemptionHistoryBloc extends Bloc<RedemptionHistoryEvent, RedemptionHistoryState> {
  final RedemptionHistoryDataProvider redemptionDataProvider;

  RedemptionHistoryBloc({required this.redemptionDataProvider}) : super(RedemptionHistoryInitial()) {
    if (redemptionDataProvider == null) {
      throw ArgumentError("redemptionDataProvider must not be null");
    }

    on<GetRedemptionHistory>((event, emit) async{
      emit(RedemptionHistoryLoading());

      final StateModel? stateModel = await redemptionDataProvider.getRedemptionData();
      if(stateModel is SuccessState) {
        emit(RedemptionHistoryLoaded(redemptionHistoryResponse: stateModel.value));
      }
    });
  }
}
