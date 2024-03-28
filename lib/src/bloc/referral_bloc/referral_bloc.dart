import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/referral/referral_code_update_request.dart';
import 'package:lets_collect/src/model/referral/referral_code_update_request_reponse.dart';
import 'package:lets_collect/src/model/referral/referral_friend_request.dart';
import 'package:lets_collect/src/model/referral/referral_friend_request_response.dart';
import 'package:lets_collect/src/model/referral/referral_list_response.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/resources/api_providers/referral_provider.dart';

part 'referral_event.dart';

part 'referral_state.dart';

class ReferralBloc extends Bloc<ReferralEvent, ReferralState> {
  final ReferralProvider referralProvider;
  ReferralBloc({required this.referralProvider}) : super(ReferralListInitial()) {
    on<GetReferralListEvent>((event, emit) async {
      emit(ReferralListLoading());
      final StateModel? stateModel = await referralProvider.getReferralList();
      if (stateModel is SuccessState) {
        emit(ReferralListLoaded(referralListResponse: stateModel.value));
      }
    });

    on<GetReferralFriendEvent>((event, emit) async {
      emit(ReferralFriendLoading());
      final StateModel? stateModel = await referralProvider.getReferralFriend(event.referralFriendRequest);
      if (stateModel is SuccessState) {
        emit(ReferralFriendLoaded(
            referralFriendRequestResponse: stateModel.value));
      }
    });

    on<GetReferralCodeUpdateEvent>((event, emit) async {
      emit(ReferralCodeUpdateLoading());
      final StateModel? stateModel = await referralProvider.getReferralCodeUpdate(event.referralCodeUpdateRequest);
      if (stateModel is SuccessState) {
        emit(ReferralCodeUpdateLoaded(
            referralCodeUpdateRequestResponse: stateModel.value));
      }
    });
  }
}
