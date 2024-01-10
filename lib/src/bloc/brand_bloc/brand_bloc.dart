import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/search/brand/search_brand_request.dart';
import 'package:lets_collect/src/model/search/brand/search_brand_request_respone.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/resources/api_providers/search_provider.dart';
import 'package:meta/meta.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  SearchProvider searchProvider;
  BrandBloc({required this.searchProvider}) : super(BrandInitial()) {
    on<GetBrandEvent>((event, emit) async {
      emit(BrandLoading());
      final StateModel? stateModel = await searchProvider.searchBrandRequest(
          event.searchBrandRequest);
      if (stateModel is SuccessState) {
        emit(BrandLoaded(searchBrandRequestResponse: stateModel.value));
      }
    }
      );
    }

}
