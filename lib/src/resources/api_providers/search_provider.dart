import 'package:dio/dio.dart';
import 'package:lets_collect/src/model/search/brand/search_brand_request.dart';
import 'package:lets_collect/src/model/search/brand/search_brand_request_respone.dart';
import 'package:lets_collect/src/model/search/category/search_category_request.dart';
import 'package:lets_collect/src/model/search/category/search_category_request_response.dart';
import '../../model/state_model.dart';
import '../../utils/data/object_factory.dart';

class SearchProvider {
  /// Category Search

  Future<StateModel?> searchCategoryRequest(
      SearchCategoryRequest searchCategoryRequest) async {
    try {
      // 404
      final response = await ObjectFactory()
          .apiClient
          .searchCategoryRequest(searchCategoryRequest);
      if (response != null) {
        if (response.statusCode == 200) {
          return StateModel<SearchCategoryRequestResponse>.success(
              SearchCategoryRequestResponse.fromJson(response.data));
        } else {}
      }
      print(response.toString());
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        return StateModel.error(e.response!.statusMessage);
        // return response!;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
      // return e;
    }
  }

  /// Brand

  Future<StateModel?> searchBrandRequest(
      SearchBrandRequest searchBrandRequest) async {
    try {
      // 404
      final response = await ObjectFactory()
          .apiClient
          .searchBrandRequest(searchBrandRequest);
      if (response != null) {
        if (response.statusCode == 200) {
          return StateModel<SearchBrandRequestResponse>.success(
              SearchBrandRequestResponse.fromJson(response.data));
        } else {}
      }
      print(response.toString());
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        return StateModel.error(e.response!.statusMessage);
        // return response!;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
      // return e;
    }
  }
}
