
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
      }    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        return StateModel.error("Oops Something went wrong!");
        // return response!;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
      // return e;
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
      }    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        return StateModel.error("Oops Something went wrong!");
        // return response!;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
      // return e;
    }
    return null;














  }

}


