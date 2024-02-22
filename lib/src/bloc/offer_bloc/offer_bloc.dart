
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/offer/offer_list_request.dart';
import 'package:lets_collect/src/model/offer/offer_list_request_response.dart';
import 'package:lets_collect/src/model/state_model.dart';

import '../../resources/api_providers/home_screen_provider.dart';

part 'offer_event.dart';
part 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  final HomeDataProvider homeDataProvider;
  OfferBloc({required this.homeDataProvider}) : super(OfferInitial()) {
    on<GetOfferListEvent>((event, emit) async{
     emit(OfferLoading());
     final StateModel? stateModel = await homeDataProvider.getOfferList(event.offerListRequest);
     if(stateModel  is SuccessState) {
       emit(OfferLoaded(offerListRequestResponse: stateModel.value));
     }
     if(stateModel is ErrorState) {
       emit(OfferErrorState(errorMsg: stateModel.msg));
     }
    });
  }
}
