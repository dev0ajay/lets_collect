import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/purchase_history/purchase_history_request.dart';
import 'package:lets_collect/src/model/purchase_history/purchase_history_response.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:meta/meta.dart';

import '../../resources/api_providers/purchase_history_screen_provider.dart';

part 'purchase_history_event.dart';
part 'purchase_history_state.dart';

class PurchaseHistoryBloc extends Bloc<PurchaseHistoryEvent, PurchaseHistoryState> {
  final PurchaseHistoryDataProvider purchaseHistoryDataProvider;
  PurchaseHistoryBloc({required this.purchaseHistoryDataProvider}) : super(PurchaseHistoryInitial()) {
    on<GetPurchaseHistory>((event, emit) async{
      emit(PurchaseHistoryLoading());
      final StateModel? stateModel = await purchaseHistoryDataProvider.purchaseHistoryRequest(event.purchaseHistoryRequest);
      if(stateModel is SuccessState){
        emit(PurchaseHistoryLoaded(purchaseHistoryResponse: stateModel.value));
      }
    }
    );

    // on<GetPurchaseHistoryDetails>((event, emit) async{
    //   emit(PurchaseHistoryDetailsLoading());
    //   final StateModel? stateModel = await purchaseHistoryDataProvider.purchaseHistoryDetailsRequest(event.purchaseHistoryDetailsRequest);
    //   if(stateModel is SuccessState){
    //     emit(PurchaseHistoryDetailsLoaded(purchaseHistoryDetailsResponse: stateModel.value));
    //   }
    // });
  }
}


