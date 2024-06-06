import 'package:dio/dio.dart';
import 'package:lets_collect/src/model/brand_and_category_filter_model/brand_and_category_filter_response.dart';
import 'package:lets_collect/src/model/redeem/qr_code_url_request.dart';
import 'package:lets_collect/src/model/redeem/qr_code_url_request_response.dart';
import 'package:lets_collect/src/model/reward_tier/brand_and_partner_product_request.dart';
import 'package:lets_collect/src/model/reward_tier/brand_and_partner_product_request_response.dart';
import 'package:lets_collect/src/model/reward_tier/reward_tier_request.dart';
import 'package:lets_collect/src/model/reward_tier/reward_tier_request_response.dart';

import '../../model/state_model.dart';
import '../../utils/data/object_factory.dart';

class RewardScreenProvider {
  ///Reward tire
  Future<StateModel?> rewardTierRequest(
      RewardTierRequest rewardTierRequest) async {
    try {
      final response =
          await ObjectFactory().apiClient.rewardTierRequest(rewardTierRequest);
      if (response.statusCode == 200) {
        return StateModel<RewardTierRequestResponse>.success(
            RewardTierRequestResponse.fromJson(response.data));
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

  ///Brand List for Filter
  Future<StateModel?> getBrandAndCategoryList() async {
    try {
      // 404
      final response =
          await ObjectFactory().apiClient.getBrandAndCategoryList();
      if (response.statusCode == 200) {
        return StateModel<BrandAndCategoryFilterResponse>.success(
            BrandAndCategoryFilterResponse.fromJson(response.data));
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

  ///Brand and Partner Product
  Future<StateModel?> getBrandAndPartnerProduct(
      BrandAndPartnerProductRequest brandAndPartnerProductRequest) async {
    try {
      final response = await ObjectFactory()
          .apiClient
          .getBrandAndPartnerProduct(brandAndPartnerProductRequest);
      if (response.statusCode == 200) {
        return StateModel<BrandAndPartnerProductRequestResponse>.success(
            BrandAndPartnerProductRequestResponse.fromJson(response.data));
      } else {}
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

  Future<StateModel?> generateQrCode(QrCodeUrlRequest qrCodeUrlRequest) async {
    try {
      final response =
          await ObjectFactory().apiClient.generateQrCode(qrCodeUrlRequest);
      if (response.statusCode == 200) {
        return StateModel<QrCodeUrlRequestResponse>.success(
            QrCodeUrlRequestResponse.fromJson(response.data));
      } else {}
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null && e.response!.statusCode == 500) {

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
