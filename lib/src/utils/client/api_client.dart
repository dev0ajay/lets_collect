import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:lets_collect/src/model/auth/forgot_password_email_model.dart';
import 'package:lets_collect/src/model/auth/forgot_password_otp_request.dart';
import 'package:lets_collect/src/model/auth/forgot_password_reset_request.dart';
import 'package:lets_collect/src/model/auth/get_city_request.dart';
import 'package:lets_collect/src/model/auth/login_request.dart';
import 'package:lets_collect/src/model/auth/sign_up_request.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import '../../model/search/brand/search_brand_request.dart';
import '../../model/search/category/search_category_request.dart';
import '../urls/urls.dart';

class ApiClient {
  ApiClient() {
    initClientLetsCollect();
  }

//for api client testing only
//   ApiClient.test({required this.dioLetsCollect});

  Dio dioLetsCollect = Dio();

  BaseOptions _baseOptionsLetsCollect = BaseOptions();

  // String usernameMyg = 'mailto:admin@finekube.com';

  // live
  // String passwordMyg = 'SA537KEDx3o2M4544O6Xh78wkgxOSH9a';

  // dev
  // String passwordMygDev = 'w4M2099455l9k9Vy6l4PA136Y62l05lX';

  /// client production

  ///client dev
  initClientLetsCollect() async {
    // String basicAuth =
    //     'Basic ' + base64Encode(utf8.encode('$usernameMyg:$passwordMygDev'));
    _baseOptionsLetsCollect = BaseOptions(
      baseUrl: UrlsLetsCollect.baseUrl,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 300000),
      followRedirects: true,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',


        // "authorization": basicAuth
      },
      responseType: ResponseType.json,
      receiveDataWhenStatusError: true,
    );

    dioLetsCollect = Dio(_baseOptionsLetsCollect);
    dioLetsCollect.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        // Don't trust any certificate just because their root cert is trusted.
        final HttpClient client =
            HttpClient(context: SecurityContext(withTrustedRoots: false));
        // You can test the intermediate / root cert here. We just ignore it.
        client.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );

    // (dioLetsCollect.httpClientAdapter
    // as HttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) {
    //     return true;
    //   };
    // };

    dioLetsCollect.interceptors.add(InterceptorsWrapper(
      onRequest: (reqOptions, handler) {
        return handler.next(reqOptions);
      },
      onError: (DioError dioError, handler) {
        return handler.next(dioError);
      },
    ));
  }

  //
  // /// get otp

  //
  // /// get otp
  // Future<Response> getOtpForExistingCustomer(phoneNo, signature) {
  //   return dioMyg.get(UrlsMyg.GET_OTP_FOR_EXISTING_CUSTOMER +
  //       phoneNo +
  //       "&userID=${ObjectFactory().prefs.getUserId()}&smsKey=$signature");
  // }
  //
  // /// get otp
  // Future<Response> addMobNumberToExistingCustomer(phoneNo) {
  //   return dioMyg.get(UrlsMyg.ADD_NUMBER_TO_EXISTING_CUSTOMER +
  //       phoneNo +
  //       "&userID=${ObjectFactory().prefs.getUserId()}");
  // }
  //
  // /// get otp
  // Future<Response> loginWithEmail(email, password, referredBy, fcmToken) {
  //   return dioMyg.get(UrlsMyg.LOGIN_WITH_EMAIL +
  //       "$email&userPassword=$password&referredBy=$referredBy&fcmToken=$fcmToken");
  // }
  //
  // /// verify otp
  // Future<Response> loginWithPhone(String phoneNo, String referredBy, fcmToken) {
  //   return dioMyg.post(UrlsMyg.LOGIN_WITH_PHONE, data: {
  //     "phoneNo": phoneNo,
  //     "referredBy": referredBy,
  //     "fcmToken": fcmToken
  //   });
  // }
  //

  ///Register
  Future<Response> registerUser(SignupRequest signupRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.SIGNUP_URL,
      data: signupRequest,
    );
  }

  //City API
  Future<Response> getCity(GetCityRequest getCityRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.CITY_URL,
      data: getCityRequest
    );
  }

  //Nationality API
  Future<Response> getNation() {
    return dioLetsCollect.get(
        UrlsLetsCollect.NATIONALITY_URL,
    );
  }

  //Country API
  Future<Response> getCountry() {
    return dioLetsCollect.get(
      UrlsLetsCollect.COUNTRY_URL,
    );
  }

///Login
  Future<Response> loginRequest(LoginRequest loginRequest) {
    return dioLetsCollect.post(
      options: Options(

      ),
      UrlsLetsCollect.LOGIN_URL,
      data: loginRequest,
    );
  }

  //Forgot Password email
  Future<Response> forgotPassword(ForgotPasswordEmailRequest forgotPasswordEmailRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.FORGOT_PASSWORD_EMAIL,
      data: forgotPasswordEmailRequest,
    );
  }
  //Forgot Password Otp
  Future<Response> forgotPasswordOtp(ForgotPasswordOtpRequest forgotPasswordOtpRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.FORGOT_PASSWORD_OTP,
      data: forgotPasswordOtpRequest,
    );
  }
  //Forgot Password Reset
  Future<Response> forgotPasswordReset(ForgotPasswordResetRequest forgotPasswordResetRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.FORGOT_PASSWORD_RESET,
      data: forgotPasswordResetRequest,
      options: Options(
        headers: {
          "Authorization": ObjectFactory().prefs.getAuthToken(),
        }
      ),

    );
  }


  ///Home Page
  Future<Response> getHomeData() {
    return dioLetsCollect.get(
      UrlsLetsCollect.HOME_DATA,
      options: Options(
          headers: {
            "Authorization": ObjectFactory().prefs.getAuthToken(),
          }
      ),
    );
  }

  ///Search Category
  Future<Response> searchCategoryRequest(SearchCategoryRequest searchCategoryRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.SEARCH_CATEGORY,
      data: searchCategoryRequest,
      options: Options(
          headers: {
            "Authorization": ObjectFactory().prefs.getAuthToken(),
          }
      ),
    );
  }

  ///Search Brand
  Future<Response> searchBrandRequest(SearchBrandRequest searchBrandRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.SEARCH_BBRAND,
      data: searchBrandRequest,
      options: Options(
          headers: {
            "Authorization": ObjectFactory().prefs.getAuthToken(),
          }
      ),
    );
  }



  Future<Response> getTermsAndConditions() {
    return dioLetsCollect.get(
      UrlsLetsCollect.TERMS_AND_CONDITIONS,

    );
  }

  Future<Response> getPrivacyPolicies() {
    return dioLetsCollect.get(
      UrlsLetsCollect.PRIVACY_POLICIES,

    );
  }


}
