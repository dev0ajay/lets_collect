
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/reward_tier/brand_and_partner_product_request.dart';
import 'package:lets_collect/src/model/reward_tier/brand_and_partner_product_request_response.dart';

import '../../model/state_model.dart';
import '../../resources/api_providers/reward_screen_provider.dart';

part 'brand_and_partner_product_event.dart';
part 'brand_and_partner_product_state.dart';

class BrandAndPartnerProductBloc extends Bloc<BrandAndPartnerProductEvent, BrandAndPartnerProductState> {
  final RewardScreenProvider rewardScreenProvider;
  BrandAndPartnerProductBloc({required this.rewardScreenProvider}) : super(BrandAndPartnerProductInitial()) {
    on<GetBrandAndPartnerProductRequest>((event, emit) async{
      emit(BrandAndPartnerProductLoading());

      final StateModel? stateModel = await rewardScreenProvider.getBrandAndPartnerProduct(event.brandAndPartnerProductRequest);
      if(stateModel is SuccessState) {
        emit(BrandAndPartnerProductLoaded(brandAndPartnerProductRequestResponse: stateModel.value));
      }
      if(stateModel is ErrorState) {
        emit(BrandAndPartnerProductErrorState(errorMsg: stateModel.msg));
      }

    });
  }
}
