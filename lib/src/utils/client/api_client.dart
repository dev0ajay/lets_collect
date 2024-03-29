import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:lets_collect/src/model/auth/forgot_password_email_model.dart';
import 'package:lets_collect/src/model/auth/forgot_password_otp_request.dart';
import 'package:lets_collect/src/model/auth/forgot_password_reset_request.dart';
import 'package:lets_collect/src/model/auth/get_city_request.dart';
import 'package:lets_collect/src/model/auth/google_login_request.dart';
import 'package:lets_collect/src/model/auth/login_request.dart';
import 'package:lets_collect/src/model/auth/sign_up_request.dart';
import 'package:lets_collect/src/model/offer/offer_list_request.dart';
import 'package:lets_collect/src/model/redeem/qr_code_url_request.dart';
import 'package:lets_collect/src/model/reward_tier/brand_and_partner_product_request.dart';
import 'package:lets_collect/src/model/reward_tier/reward_tier_request.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import '../../model/scan_receipt/scan_receipt_history_request.dart';
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

  /// The request info for the request that throws exception.
  RequestOptions? requestOptions;

  /// Response info, it may be `null` if the request can't reach to the
  /// HTTP server, for example, occurring a DNS error, network is not available.
  Response? response;

  /// The type of the current [DioException].
  DioExceptionType? type;

  /// The original error/exception object;
  /// It's usually not null when `type` is [DioExceptionType.unknown].
  Object? error;

  /// The stacktrace of the original error/exception object;
  /// It's usually not null when `type` is [DioExceptionType.unknown].
  StackTrace? stackTrace;

  /// The error message that throws a [DioException].
  String? message;

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
    return dioLetsCollect.post(UrlsLetsCollect.CITY_URL, data: getCityRequest);
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
      options: Options(),
      UrlsLetsCollect.LOGIN_URL,
      data: loginRequest,
    );
  }

  //Forgot Password email
  Future<Response> forgotPassword(
      ForgotPasswordEmailRequest forgotPasswordEmailRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.FORGOT_PASSWORD_EMAIL,
      data: forgotPasswordEmailRequest,
    );
  }

  //Forgot Password Otp
  Future<Response> forgotPasswordOtp(
      ForgotPasswordOtpRequest forgotPasswordOtpRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.FORGOT_PASSWORD_OTP,
      data: forgotPasswordOtpRequest,
    );
  }

  //Forgot Password Reset
  Future<Response> forgotPasswordReset(
      ForgotPasswordResetRequest forgotPasswordResetRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.FORGOT_PASSWORD_RESET,
      data: forgotPasswordResetRequest,
      options: Options(headers: {
        "Authorization": ObjectFactory().prefs.getAuthToken(),
      }),
    );
  }

  ///Home Page
  Future<Response> getHomeData() {
    return dioLetsCollect.get(
      UrlsLetsCollect.HOME_DATA,
      options: Options(headers: {
        "Authorization": ObjectFactory().prefs.getAuthToken(),
      }),
    );
  }

  ///Search Category
  Future<Response> searchCategoryRequest(
      SearchCategoryRequest searchCategoryRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.SEARCH_CATEGORY,
      data: searchCategoryRequest,
      options: Options(headers: {
        "Authorization": ObjectFactory().prefs.getAuthToken(),
      }),
    );
  }

  ///Search Brand
  Future<Response> searchBrandRequest(SearchBrandRequest searchBrandRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.SEARCH_BBRAND,
      data: searchBrandRequest,
      options: Options(headers: {
        "Authorization": ObjectFactory().prefs.getAuthToken(),
      }),
    );
  }

  ///Profile
  //Terms and Conditions
  Future<Response> getTermsAndConditions() {
    return dioLetsCollect.get(
      UrlsLetsCollect.TERMS_AND_CONDITIONS,
    );
  }

  //Privacy Policies
  Future<Response> getPrivacyPolicies() {
    return dioLetsCollect.get(
      UrlsLetsCollect.PRIVACY_POLICIES,
    );
  }

  ///Reward Screen

// Brand List
  Future<Response> getBrandAndCategoryList() {
    return dioLetsCollect.get(
      UrlsLetsCollect.BRAND_AND_CATEGORY_LIST,
      options: Options(headers: {
        "Authorization": ObjectFactory().prefs.getAuthToken(),
      }),
    );
  }


  ///Reward Tier
  Future<Response> rewardTierRequest(RewardTierRequest rewardTierRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.REWARD_TIER_REQUEST,
      data: rewardTierRequest,
      options: Options(headers: {
        "Authorization": ObjectFactory().prefs.getAuthToken(),
      }),
    );


  }

  //Brand And Partner Product
  Future<Response> getBrandAndPartnerProduct(BrandAndPartnerProductRequest brandAndPartnerProductRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.BRAND_AND_PARTNER_TIER_PRODUCT,
      data: brandAndPartnerProductRequest,
      options: Options(headers: {
        "Authorization": ObjectFactory().prefs.getAuthToken(),
      }),
    );


  }


  Future<Response> uploadReceipt(FormData formData) {
    return dioLetsCollect.post(
      UrlsLetsCollect.SCAN_RECEIPT,
      data: formData,
      options: Options(headers: {
        "Authorization": ObjectFactory().prefs.getAuthToken(),
      }),
    );
  }

  Future<Response> getOfferList(OfferListRequest offerListRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.OFFER_LIST,
      data: offerListRequest,
      options: Options(headers: {
        "Authorization": ObjectFactory().prefs.getAuthToken(),
      }),
    );
  }

  Future<Response> showScanHistory(ScanReceiptHistoryRequest scanReceiptHistoryRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.SCAN_HISTORY,
      data: scanReceiptHistoryRequest,
      options: Options(headers: {
        "Authorization": ObjectFactory().prefs.getAuthToken(),
      }),
    );
  }


  Future<Response> generateQrCode(QrCodeUrlRequest qrCodeUrlRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.QR_CODE,
      data: qrCodeUrlRequest,
      options: Options(headers: {
        "Authorization": ObjectFactory().prefs.getAuthToken(),
      }),
    );
  }

  Future<Response> googleLogin(GoogleLoginRequest googleLoginRequest) {
    return dioLetsCollect.post(
      UrlsLetsCollect.GOOGLE_LOGIN,
      data: googleLoginRequest,
    );
  }


}
