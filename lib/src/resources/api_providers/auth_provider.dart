import 'package:dio/dio.dart';
import 'package:lets_collect/src/model/auth/forgot_password_email_model.dart';
import 'package:lets_collect/src/model/auth/forgot_password_email_response.dart';
import 'package:lets_collect/src/model/auth/forgot_password_otp_request.dart';
import 'package:lets_collect/src/model/auth/forgot_password_otp_request_response.dart';
import 'package:lets_collect/src/model/auth/get_Nationality_Response.dart';
import 'package:lets_collect/src/model/auth/get_city_request.dart';
import 'package:lets_collect/src/model/auth/get_country_response.dart';
import 'package:lets_collect/src/model/auth/google_login_request.dart';
import 'package:lets_collect/src/model/auth/google_login_response.dart';
import 'package:lets_collect/src/model/auth/login_request.dart';
import 'package:lets_collect/src/model/auth/login_request_response.dart';
import 'package:lets_collect/src/model/auth/sign_up_error_response_model.dart';

import '../../model/auth/forgot_password_reset_request.dart';
import '../../model/auth/forgot_password_reset_request_response.dart';
import '../../model/auth/get_city_response.dart';
import '../../model/auth/response.dart';
import '../../model/auth/sign_up_request.dart';
import '../../model/state_model.dart';
import '../../utils/data/object_factory.dart';

class AuthProvider{

///Register
  Future<StateModel?> registerUser(SignupRequest signupRequest) async {
    final response = await ObjectFactory().apiClient.registerUser(signupRequest);
    print(response.toString());
    print(response.data["status"]);
    if (response.statusCode == 200 && response.data["success"] == true) {
      return StateModel<SignUpRequestResponse>.success(
          SignUpRequestResponse.fromJson(response.data));
    }
    else if (response.data["success"] == false && response.statusCode == 200) {
      return StateModel<SignUpRequestErrorResponse>.error(
        SignUpRequestErrorResponse.fromJson(response.data));
    }
      return null;
  }



///Login
  Future<StateModel?> loginRequest(LoginRequest loginRequest) async {
    final response = await ObjectFactory().apiClient.loginRequest(loginRequest);
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<LoginRequestResponse>.success(
          LoginRequestResponse.fromJson(response.data));
    } else {
      return null;
    }  }


///City
  Future<StateModel?> getCity(GetCityRequest getCityRequest) async {
    final response = await ObjectFactory().apiClient.getCity(getCityRequest);
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<GetCityResponse>.success(
          GetCityResponse.fromJson(response.data));
    } else {
      return null;
    }  }

  ///Nation
  Future<StateModel?> getNation() async {
    final response = await ObjectFactory().apiClient.getNation();
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<NationalityResponse>.success(
          NationalityResponse.fromJson(response.data));
    } else {
      return null;
    }  }

  ///Country
  Future<StateModel?> getCountry() async {
    final response = await ObjectFactory().apiClient.getCountry();
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<CountryResponse>.success(
          CountryResponse.fromJson(response.data));
    } else {
      return null;
    }  }

///Forgot Password

  Future<StateModel?> forgotPassword(ForgotPasswordEmailRequest forgotPasswordEmailRequest) async {

    try {
      // 404
      final response =
      await ObjectFactory().apiClient.forgotPassword(forgotPasswordEmailRequest);
      print(response.toString());
      if (response.statusCode == 200) {
        return StateModel<ForgotPasswordEmailRequestResponse>.success(
            ForgotPasswordEmailRequestResponse.fromJson(response.data));
      } else {

      }
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

        print(e.requestOptions);
        print(e.message);
      }
      // return e;
    }
    return null;

  }
  //Forgot Password Otp Provider
  Future<StateModel?> forgotPasswordOtp(ForgotPasswordOtpRequest forgotPasswordOtpRequest) async {
    final response = await ObjectFactory().apiClient.forgotPasswordOtp(forgotPasswordOtpRequest);
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<ForgotPasswordOtpRequestResponse>.success(
          ForgotPasswordOtpRequestResponse.fromJson(response.data));
    } else {
      return null;
    }  }

  //Forgot Password reset Provider
  Future<StateModel?> forgotPasswordReset(ForgotPasswordResetRequest forgotPasswordResetRequest) async {
    final response = await ObjectFactory().apiClient.forgotPasswordReset(forgotPasswordResetRequest);
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<ForgotPasswordResetRequestResponse>.success(
          ForgotPasswordResetRequestResponse.fromJson(response.data));
    } else {
      return null;
    }  }

  Future<StateModel?> googleLogin(GoogleLoginRequest googleLoginRequest) async {
    final response = await ObjectFactory().apiClient.googleLogin(googleLoginRequest);
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<GoogleLoginResponse>.success(
          GoogleLoginResponse.fromJson(response.data));
    } else {
      return null;
    }  }




}