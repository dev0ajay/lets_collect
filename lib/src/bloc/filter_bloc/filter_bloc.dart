import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/brand_and_category_filter_model/brand_and_category_filter_response.dart';
import 'package:lets_collect/src/model/state_model.dart';
import '../../resources/api_providers/reward_screen_provider.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final RewardScreenProvider rewardScreenProvider;
  FilterBloc({required this.rewardScreenProvider}) : super(FilterInitial()) {
    on<GetBrandAndCategoryFilterList>((event, emit) async{
      emit(BrandLoading());
      final StateModel? stateModel = await rewardScreenProvider.getBrandAndCategoryList();
      if(stateModel is SuccessState) {
        emit(BrandLoaded(brandAndCategoryFilterResponse: stateModel.value));
      }
    });

  }
}
