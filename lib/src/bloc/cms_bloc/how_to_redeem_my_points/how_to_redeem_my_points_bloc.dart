import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/cms/how_to_redeem_my_points.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/resources/api_providers/profile_screen_provider.dart';

part 'how_to_redeem_my_points_event.dart';
part 'how_to_redeem_my_points_state.dart';

class HowToRedeemMyPointsBloc extends Bloc<HowToRedeemMyPointsEvent, HowToRedeemMyPointsState> {
  final MyProfileDataProvider profileDataProvider;
  HowToRedeemMyPointsBloc({required this.profileDataProvider}) : super(HowToRedeemMyPointsInitial()) {
    on<GetHowToRedeemMyPointsEvent>((event, emit) async{
      emit(HowToRedeemMyPointsLoading());
      final StateModel? stateModel = await profileDataProvider.getHowToRedeemMyPoints();
      if(stateModel is SuccessState) {
        emit(HowToRedeemMyPointsLoaded(howToRedeemMyPointsResponse: stateModel.value));
      }
    });
  }
}
