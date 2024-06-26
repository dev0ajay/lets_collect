
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/search/category/search_category_request.dart';
import 'package:lets_collect/src/model/search/category/search_category_request_response.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/resources/api_providers/search_provider.dart';
import 'package:meta/meta.dart';

import '../../model/search/brand/search_brand_request.dart';
import '../../model/search/brand/search_brand_request_respone.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchProvider searchProvider;
  SearchBloc({required this.searchProvider}) : super(SearchInitial()) {
    on<GetSearchEvent>((event, emit) async{
      emit(SearchLoading());

      final StateModel? stateModel = await searchProvider.searchCategoryRequest(event.searchCategoryRequest);
      if(stateModel is SuccessState) {
        emit(SearchLoaded(searchCategoryRequestResponse: stateModel.value));
      }else if(stateModel is ErrorState){
        emit(SearchErrorState(msg: stateModel.msg));
      }
    }

    );
    on<GetBrandEvent>((event, emit) async {
      emit(BrandLoading());
      final StateModel? stateModel = await searchProvider.searchBrandRequest(
          event.searchBrandRequest);
      if (stateModel is SuccessState) {
        emit(BrandLoaded(searchBrandRequestResponse: stateModel.value));
      }else if(stateModel is ErrorState) {
        emit(BrandErrorState(msg: stateModel.msg));
      }
    }
    );
  }
}
