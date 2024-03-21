import 'package:dio/dio.dart';
import 'package:lets_collect/src/model/cms/point_calculations.dart';
import 'package:lets_collect/src/model/cms/privacy_policies.dart';
import 'package:lets_collect/src/model/cms/terms_and_condition.dart';
import 'package:lets_collect/src/model/profile/delete_request_response.dart';
import '../../model/cms/how_to_redeem_my_points.dart';
import '../../model/contact_us/contact_us_request.dart';
import '../../model/contact_us/contact_us_response.dart';
import '../../model/edit_profile/edit_profile_request.dart';
import '../../model/edit_profile/edit_profile_request_response.dart';
import '../../model/profile/my_profile_screen_response.dart';
import '../../model/state_model.dart';
import '../../utils/data/object_factory.dart';

class ProfileDataProvider {
  ///Terms and conditions
  Future<StateModel?> getTermsAndConditions() async {
    final response = await ObjectFactory().apiClient.getTermsAndConditions();
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<TermsAndConditionResponse>.success(
          TermsAndConditionResponse.fromJson(response.data));
    } else {
      return null;
    }
  }

  ///Privacy policies
  Future<StateModel?> getPrivacyPolicies() async {
    final response = await ObjectFactory().apiClient.getPrivacyPolicies();
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<PrivacyPoliciesResponse>.success(
          PrivacyPoliciesResponse.fromJson(response.data));
    } else {
      return null;
    }
  }

  ///GetProfile
  Future<StateModel?> getProfileData() async {

    try {
      final response = await ObjectFactory().apiClient.getProfileData();
      print(response.toString());

      if (response != null) {
        if (response.statusCode == 200) {
          return StateModel<MyProfileScreenResponse>.success(
              MyProfileScreenResponse.fromJson(response.data));
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on DioException catch (e) {
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

  }

  ///EditProfile
  Future<StateModel?> getEditProfileData(
      EditProfileRequest editProfileRequest) async {
    try {
      final response = await ObjectFactory()
          .apiClient
          .getEditProfileData(editProfileRequest);
      print(response.toString());

      if (response != null) {
        if (response.statusCode == 200) {
          return StateModel<EditProfileRequestResponse>.success(
              EditProfileRequestResponse.fromJson(response.data));
        } else {
          return null;
        }
      } else {
        return null;
      }
    } on DioException catch (e) {
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
  }


  ///Contact us
  Future<StateModel?> contactUsRequest(ContactUsRequest contactUsRequest) async {
    try{
      final response = await ObjectFactory().apiClient.contactUsRequestClient(contactUsRequest);
      print(response.toString());
      if (response != null) {
        if (response.statusCode == 200) {
          return StateModel<ContactUsRequestResponse>.success(
              ContactUsRequestResponse.fromJson(response.data));
        } else {
          return null;
        }
      } else {
        return null;
      }
    }on DioException catch (e) {
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

  }

  ///How To Redeem My Points
  Future<StateModel?> getHowToRedeemMyPoints() async {
    try{
      final response = await ObjectFactory().apiClient.getHowToRedeemMyPoints();
      print(response.toString());
      if (response.statusCode == 200) {
        return StateModel<HowToRedeemMyPointsResponse>.success(
            HowToRedeemMyPointsResponse.fromJson(response.data));
      } else {
        return null;
      }
    }on DioException catch (e) {
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
  }

  /// Point Calculations
  Future<StateModel?> getPointCalculations() async {
    try{
      final response = await ObjectFactory().apiClient.getPointCalculations();
      print(response.toString());
      if (response.statusCode == 200) {
        return StateModel<PointCalculationsResponse>.success(
            PointCalculationsResponse.fromJson(response.data));
      } else {
        return null;
      }
    }on DioException catch (e) {
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
  }


  /// Delete Account
  Future<StateModel?> deleteAccount() async {
    try{
      final response = await ObjectFactory().apiClient.deleteAccount();
      print(response.toString());
      if (response.statusCode == 200) {
        return StateModel<DeleteAccountRequestResponse>.success(
            DeleteAccountRequestResponse.fromJson(response.data));
      } else {
        return null;
      }
    }on DioException catch (e) {
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
  }


}
