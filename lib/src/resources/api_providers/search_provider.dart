import 'package:lets_collect/src/model/search/brand/search_brand_request.dart';
import 'package:lets_collect/src/model/search/brand/search_brand_request_respone.dart';
import 'package:lets_collect/src/model/search/category/search_category_request.dart';
import 'package:lets_collect/src/model/search/category/search_category_request_response.dart';
import '../../model/state_model.dart';
import '../../utils/data/object_factory.dart';

class SearchProvider{

  /// Category Search

  Future<StateModel?> searchCategoryRequest(SearchCategoryRequest searchCategoryRequest) async {
    final response = await ObjectFactory().apiClient.searchCategoryRequest(searchCategoryRequest);
    print(response.toString());
    if(response!=null){
      if (response.statusCode == 200) {
        return StateModel<SearchCategoryRequestResponse>.success(
            SearchCategoryRequestResponse.fromJson(response.data));
      } else {
        return null;
      }}
    else{
      return null;
    }
  }

  /// Brand

  Future<StateModel?> searchBrandRequest(SearchBrandRequest searchBrandRequest) async {
    final response = await ObjectFactory().apiClient.searchBrandRequest(searchBrandRequest);
    print(response.toString());
    if(response!=null){
      if (response.statusCode == 200) {
        return StateModel<SearchBrandRequestResponse>.success(
            SearchBrandRequestResponse.fromJson(response.data));
      } else {
        return null;
      }}
    else{
      return null;
    }
  }

}