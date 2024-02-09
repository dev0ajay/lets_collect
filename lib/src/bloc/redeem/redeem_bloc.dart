import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/redeem/qr_code_url_request.dart';
import 'package:lets_collect/src/model/redeem/qr_code_url_request_response.dart';
import 'package:lets_collect/src/model/state_model.dart';

import '../../resources/api_providers/reward_screen_provider.dart';

part 'redeem_event.dart';
part 'redeem_state.dart';

class RedeemBloc extends Bloc<RedeemEvent, RedeemState> {
  final RewardScreenProvider rewardScreenProvider;
  RedeemBloc({required this.rewardScreenProvider}) : super(RedeemInitial()) {
    on<GetQrCodeUrlEvent>((event, emit) async{
      emit(RedeemLoading());

      final StateModel? stateModel = await rewardScreenProvider.generateQrCode(event.qrCodeUrlRequest);
      if(stateModel is SuccessState) {
        emit(RedeemLoaded(qrCodeUrlRequestResponse: stateModel.value));
      }
    });
  }
}
