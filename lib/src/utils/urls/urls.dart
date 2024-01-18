class UrlsLetsCollect {
  ///base urls
  static const String baseUrl = 'https://letscollect.demoatcrayotech.com';

  /// Signup screen
  static const String  SIGNUP_URL= "/api/register";
  static const String CITY_URL = "/api/city_list";
  static const String NATIONALITY_URL = "/api/lcadmin/nationality_list";
  static const String COUNTRY_URL = "/api/lcadmin/country_list";




  /// login screen
  static const String  LOGIN_URL= "/api/login";
  static const String  FORGOT_PASSWORD_EMAIL= "/api/forgotpassword";
  static const String  FORGOT_PASSWORD_OTP= "/api/forgotpassword_otp_verification";
  static const String  FORGOT_PASSWORD_RESET= "/api/recover_password";

  ///Search Category
  static const String SEARCH_CATEGORY = "/api/lcuser/category_search";
  ///Search Brand
  static const String SEARCH_BBRAND = "/api/lcuser/brand_search";



  ///Home Data
  static const String HOME_DATA = "/api/lcuser/customer_home";


  ///Profile
  static const String TERMS_AND_CONDITIONS = "/api/lcuser/terms_and_conditions";
  static const String PRIVACY_POLICIES = "/api/lcuser/terms_and_conditions";

}
