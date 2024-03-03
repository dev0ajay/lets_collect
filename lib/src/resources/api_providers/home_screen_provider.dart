
import 'package:dio/dio.dart';
import 'package:lets_collect/src/model/home/home_page_response.dart';
import 'package:lets_collect/src/model/offer/offer_list_request.dart';
import 'package:lets_collect/src/model/offer/offer_list_request_response.dart';
import '../../model/state_model.dart';
import '../../utils/data/object_factory.dart';

class HomeDataProvider {
  Future<StateModel?> getHomeData() async {

    try {

      final response = await ObjectFactory().apiClient.getHomeData();
      if (response.statusCode == 200) {
        return StateModel<HomeResponse>.success(
            HomeResponse.fromJson(response.data));
      } else {
        return null;
      }    }  on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null && e.response!.statusCode == 500) {
        // print(e.response!.statusCode == 500);
        print("Error: ${e.error.toString()}");
        print("Error msg: ${e.message}");
        print("Error type: ${e.type}");
        return StateModel.error(
            "The server isn't responding! Please try again later.");
        // return response!;
      } else if (e.response != null && e.response!.statusCode == 408) {
        return StateModel.error(
            "Hello there! It seems like your request took longer than expected to process. We apologize for the inconvenience. Please try again later or reach out to our support team for assistance. Thank you for your patience!");
        // Something happened in setting up or sending the request that triggered an Error
      }
    }
    return null;

  }

  ///Offer List
  Future<StateModel?> getOfferList(OfferListRequest offerListRequest) async {

    try {

      final response = await ObjectFactory().apiClient.getOfferList(offerListRequest);
      print(response.toString());
      if (response.statusCode == 200) {
        return StateModel<OfferListRequestResponse>.success(
            OfferListRequestResponse.fromJson(response.data));
      } else {
        return null;
      }
    }  on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null && e.response!.statusCode == 500) {
        // print(e.response!.statusCode == 500);
        print("Error: ${e.error.toString()}");
        print("Error msg: ${e.message}");
        print("Error type: ${e.type}");
        return StateModel.error(
            "The server isn't responding! Please try again later.");
        // return response!;
      } else if (e.response != null && e.response!.statusCode == 408) {
        return StateModel.error(
            "Hello there! It seems like your request took longer than expected to process. We apologize for the inconvenience. Please try again later or reach out to our support team for assistance. Thank you for your patience!");
        // Something happened in setting up or sending the request that triggered an Error
      }
    }
    return null;

  }

}


