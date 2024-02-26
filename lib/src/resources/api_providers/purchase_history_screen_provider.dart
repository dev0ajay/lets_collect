/// Purchase History Provider


import 'package:dio/dio.dart';
import 'package:lets_collect/src/model/purchase_history/purchase_history_request.dart';
import 'package:lets_collect/src/model/purchase_history/purchase_history_response.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import '../../model/purchase_history/supermarket_list_response.dart';

class PurchaseHistoryDataProvider {
  Future<StateModel?> purchaseHistoryRequest(PurchaseHistoryRequest purchaseHistoryRequest) async {
    final response = await ObjectFactory().apiClient.purchaseHistoryRequest(purchaseHistoryRequest);
    print(response.toString());
    if(response!=null){
      if (response.statusCode == 200) {
        return StateModel<PurchaseHistoryResponse>.success(
            PurchaseHistoryResponse.fromJson(response.data));
      } else {
        return null;
      }}
    else{
      return null;
    }
  }


  // Future<StateModel?> purchaseHistoryDetailsRequest(PurchaseHistoryDetailsRequest purchaseHistoryDetailsRequest) async {
  //   final response = await ObjectFactory().apiClient.purchaseHistoryDetailsRequest(purchaseHistoryDetailsRequest);
  //   print(response.toString());
  //
  //   if(response!=null){
  //     if (response.statusCode == 200) {
  //       return StateModel<PurchaseHistoryDetailsResponse>.success(
  //           PurchaseHistoryDetailsResponse.fromJson(response.data));
  //     } else {
  //       return null;
  //     }}
  //   else{
  //     return null;
  //   }
  // }


///Super Market History Screen Filter

  Future<StateModel?> getSuperMarketList() async {
    try {
      // 404
      final response =
      await ObjectFactory().apiClient.getSuperMarketList();
      if (response != null) {
        if (response.statusCode == 200) {
          return StateModel<SuperMarketListResponse>.success(
              SuperMarketListResponse.fromJson(response.data));
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
    return null;
  }

}