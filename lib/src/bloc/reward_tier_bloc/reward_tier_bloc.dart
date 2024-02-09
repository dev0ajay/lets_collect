
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/reward_tier/reward_tier_request.dart';
import 'package:lets_collect/src/model/reward_tier/reward_tier_request_response.dart';
import 'package:lets_collect/src/model/state_model.dart';

import '../../resources/api_providers/reward_screen_provider.dart';

part 'reward_tier_event.dart';
part 'reward_tier_state.dart';

class RewardTierBloc extends Bloc<RewardTierEvent, RewardTierState> {
  final RewardScreenProvider rewardScreenProvider ;
  RewardTierBloc({required this.rewardScreenProvider}) : super(RewardTierInitial()) {
    on<RewardTierRequestEvent>((event, emit) async{
      emit(RewardTierLoading());

      final StateModel? stateModel = await rewardScreenProvider.rewardTierRequest(event.rewardTierRequest);
      if(stateModel is SuccessState) {
        emit(RewardTierLoaded(rewardTierRequestResponse: stateModel.value));
      }
      if(stateModel is ErrorState) {
        emit(RewardTierError( errorMsg: stateModel.msg));
      }
    });
  }
}
