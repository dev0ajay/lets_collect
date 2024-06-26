import 'package:dio/dio.dart';
import 'package:lets_collect/src/model/purchase_history/purchase_history_request.dart';
import 'package:lets_collect/src/model/purchase_history/purchase_history_response.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import '../../model/point_tracker/point_tracker_details_request.dart';
import '../../model/point_tracker/point_tracker_details_response.dart';
import '../../model/point_tracker/point_tracker_request.dart';
import '../../model/point_tracker/point_tracker_response.dart';
import '../../model/purchase_history/purchase_history_details_request.dart';
import '../../model/purchase_history/purchase_history_details_response.dart';
import '../../model/purchase_history/supermarket_list_response.dart';

class PurchaseDataProvider {
  ///Purchase History
  Future<StateModel?> purchaseHistoryRequest(
      PurchaseHistoryRequest purchaseHistoryRequest) async {
    try {
      final response = await ObjectFactory()
          .apiClient
          .purchaseHistoryRequest(purchaseHistoryRequest);
      if (response.statusCode == 200) {
        return StateModel<PurchaseHistoryResponse>.success(
            PurchaseHistoryResponse.fromJson(response.data));
      } else {
        return null;
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null && e.response!.statusCode == 500) {

        return StateModel.error(
            "The server isn't responding! Please try again later.");
      } else if (e.response != null && e.response!.statusCode == 408) {
        return StateModel.error(
            "Hello there! It seems like your request took longer than expected to process. We apologize for the inconvenience. Please try again later or reach out to our support team for assistance. Thank you for your patience!");
        // Something happened in setting up or sending the request that triggered an Error
      }
    }
    return null;
    // return null;
  }

  ///Purchase History Details
  Future<StateModel?> purchaseHistoryDetailsRequest(
      PurchaseHistoryDetailsRequest purchaseHistoryDetailsRequest) async {
    try {
      final response = await ObjectFactory()
          .apiClient
          .purchaseHistoryDetailsRequest(purchaseHistoryDetailsRequest);
      if (response.statusCode == 200) {

        return StateModel<PurchaseHistoryDetailsResponse>.success(
            PurchaseHistoryDetailsResponse.fromJson(response.data));
      } else {
        return null;
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null && e.response!.statusCode == 500) {

        return StateModel.error(
            "The server isn't responding! Please try again later.");
      } else if (e.response != null && e.response!.statusCode == 408) {
        return StateModel.error(
            "Hello there! It seems like your request took longer than expected to process. We apologize for the inconvenience. Please try again later or reach out to our support team for assistance. Thank you for your patience!");
        // Something happened in setting up or sending the request that triggered an Error
      }
    }
    return null;
  }

  ///Super Market History Screen Filter
  Future<StateModel?> getSuperMarketList() async {
    try {
      // 404
      final response = await ObjectFactory().apiClient.getSuperMarketList();
      if (response.statusCode == 200) {

        return StateModel<SuperMarketListResponse>.success(
            SuperMarketListResponse.fromJson(response.data));
      } else {
        return null;
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        return StateModel.error(e.response!.statusMessage);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
      }
      // return e;
    }
    return null;
  }

  ///Point Tracker
  Future<StateModel?> pointTrackerRequest(
      PointTrackerRequest pointTrackerRequest) async {
    try {
      // 404
      final response = await ObjectFactory()
          .apiClient
          .pointTrackerRequest(pointTrackerRequest);
      if (response.statusCode == 200) {

        return StateModel<PointTrackerRequestResponse>.success(
            PointTrackerRequestResponse.fromJson(response.data));
      } else {
        return null;
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {

        return StateModel.error(e.response!.statusMessage);
      } else {
        // Something happened in setting up or sending the request that triggered an Error

      }
    }
    return null;
  }

  ///Point Tracker Details
  Future<StateModel?> pointTrackerDetailsRequest(
      PointTrackerDetailsRequest pointTrackerDetailsRequest) async {
    try {
      // 404
      final response = await ObjectFactory()
          .apiClient
          .pointTrackerDetailsRequest(pointTrackerDetailsRequest);
      if (response.statusCode == 200) {

        return StateModel<PointTrackerDetailsRequestResponse>.success(
            PointTrackerDetailsRequestResponse.fromJson(response.data));
      } else {
        return null;
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {

        return StateModel.error(e.response!.statusMessage);
        // return response!;
      } else {
        // Something happened in setting up or sending the request that triggered an Error

      }
      // return e;
    }
    return null;
  }
}
