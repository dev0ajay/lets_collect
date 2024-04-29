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
      if (response.statusCode == 200) {
        print(response.toString());
        return StateModel<SearchCategoryRequestResponse>.success(
            SearchCategoryRequestResponse.fromJson(response.data));
      } else {}
          print(response.toString());
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null && e.response!.statusCode == 500) {
        // print(e.response!.statusCode == 500);
        print("Error: ${e.error.toString()}");
        print("Error msg: ${e.message}");
        print("Error type: ${e.type}");
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
        return StateModel.error("The server isn't responding! Please try again later.");
        // return response!;
      } else if(e.response != null && e.response!.statusCode == 408){
        return StateModel.error("Hello there! It seems like your request took longer than expected to process. We apologize for the inconvenience. Please try again later or reach out to our support team for assistance. Thank you for your patience!");
        // Something happened in setting up or sending the request that triggered an Error
      }else if(e.response != null && e.response!.statusCode == 404){
        return StateModel.error("Please try again later or reach out to our support team for assistance. Thank you for your patience!");
        // Something happened in setting up or sending the request that triggered an Error
      }
    }
    return null;
  }

  /// Brand

  Future<StateModel?> searchBrandRequest(
      SearchBrandRequest searchBrandRequest) async {
    try {
      // 404
      final response = await ObjectFactory()
          .apiClient
          .searchBrandRequest(searchBrandRequest);
      if (response.statusCode == 200) {
        return StateModel<SearchBrandRequestResponse>.success(
            SearchBrandRequestResponse.fromJson(response.data));
      } else {
        return StateModel.error("The server isn't responding! Please try again later.");
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null && e.response!.statusCode == 500) {
        // print(e.response!.statusCode == 500);
        print("Error: ${e.error.toString()}");
        print("Error msg: ${e.message}");
        print("Error type: ${e.type}");
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
        return StateModel.error("The server isn't responding! Please try again later.");
        // return response!;
      } else if(e.response != null && e.response!.statusCode == 408){
        return StateModel.error("Hello there! It seems like your request took longer than expected to process. We apologize for the inconvenience. Please try again later or reach out to our support team for assistance. Thank you for your patience!");
        // Something happened in setting up or sending the request that triggered an Error
      }else if(e.response != null && e.response!.statusCode == 404){
        return StateModel.error("Please try again later or reach out to our support team for assistance. Thank you for your patience!");
        // Something happened in setting up or sending the request that triggered an Error
      }

    }
    return null;
  }
}
