import 'package:dio/dio.dart';
import 'package:lets_collect/src/model/brand_and_category_filter_model/brand_and_category_filter_response.dart';
import 'package:lets_collect/src/model/category/category_model.dart';
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
      if (response != null) {
        if (response.statusCode == 200) {
          return StateModel<RewardTierRequestResponse>.success(
              RewardTierRequestResponse.fromJson(response.data));
        } else {}
      }
      print(response.toString());
    } on DioException catch (e) {

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

  ///Brand List for Filter
  Future<StateModel?> getBrandAndCategoryList() async {
    try {
      // 404
      final response =
          await ObjectFactory().apiClient.getBrandAndCategoryList();
      if (response != null) {
        if (response.statusCode == 200) {
          return StateModel<BrandAndCategoryFilterResponse>.success(
              BrandAndCategoryFilterResponse.fromJson(response.data));
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


  ///Brand and Partner Product
  Future<StateModel?> getBrandAndPartnerProduct(
      BrandAndPartnerProductRequest brandAndPartnerProductRequest
      ) async {
    try {
      final response =
      await ObjectFactory().apiClient.getBrandAndPartnerProduct(brandAndPartnerProductRequest);
      if (response != null) {
        print(response.toString());
        if (response.statusCode == 200) {
          return StateModel<BrandAndPartnerProductRequestResponse>.success(
              BrandAndPartnerProductRequestResponse.fromJson(response.data));
        } else {}
      }
      // print(response.toString());
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


  Future<StateModel?> generateQrCode(
      QrCodeUrlRequest qrCodeUrlRequest
      ) async {
    try {
      final response =
      await ObjectFactory().apiClient.generateQrCode(qrCodeUrlRequest);
      if (response != null) {
        print(response.toString());
        if (response.statusCode == 200) {
          return StateModel<QrCodeUrlRequestResponse>.success(
              QrCodeUrlRequestResponse.fromJson(response.data));
        } else {}
      }
      // print(response.toString());
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
