import 'package:dio/dio.dart';
import 'package:lets_collect/src/model/referral/referral_code_update_request.dart';
import 'package:lets_collect/src/model/referral/referral_code_update_request_reponse.dart';
import 'package:lets_collect/src/model/referral/referral_friend_request.dart';
import 'package:lets_collect/src/model/referral/referral_friend_request_response.dart';
import 'package:lets_collect/src/model/referral/referral_list_response.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';

class ReferralProvider {
  /// Referral List
  Future<StateModel?> getReferralList() async {
    try {
      final response =
          await ObjectFactory().apiClient.getReferralListResponse();

      if (response.statusCode == 200) {
        return StateModel<ReferralListResponse>.success(
            ReferralListResponse.fromJson(response.data));
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

  /// Referral Friend
  Future<StateModel?> getReferralFriend(
      ReferralFriendRequest referralFriendRequest) async {
    try {
      final response = await ObjectFactory()
          .apiClient
          .getReferralFriendRequestResponse(referralFriendRequest);

      if (response.statusCode == 200) {
        return StateModel<ReferralFriendRequestResponse>.success(
            ReferralFriendRequestResponse.fromJson(response.data));
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

  /// Referral Code Update
  Future<StateModel?> getReferralCodeUpdate(
      ReferralCodeUpdateRequest referralCodeUpdateRequest) async {
    try {
      final response = await ObjectFactory()
          .apiClient
          .getReferralCodeUpdateClient(referralCodeUpdateRequest);

      if (response.statusCode == 200) {
        return StateModel<ReferralCodeUpdateRequestResponse>.success(
            ReferralCodeUpdateRequestResponse.fromJson(response.data));
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
}
