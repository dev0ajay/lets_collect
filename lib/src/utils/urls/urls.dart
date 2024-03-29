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
  static const String  GOOGLE_LOGIN= "/api/google_login";


  ///Search Category
  static const String SEARCH_CATEGORY = "/api/lcuser/category_search";
  ///Search Brand
  static const String SEARCH_BBRAND = "/api/lcuser/brand_search";

  ///Home Screen
  static const String HOME_DATA = "/api/lcuser/customer_home";


  ///Profile Screen
  static const String TERMS_AND_CONDITIONS = "/api/lcuser/terms_and_conditions";
  static const String PRIVACY_POLICIES = "/api/lcuser/terms_and_conditions";


  ///Reward Screen
  static const String BRAND_AND_CATEGORY_LIST = "/api/lcuser/brand_category_list";
  static const String REWARD_TIER_REQUEST = "/api/lcuser/rewards";
  static const String BRAND_AND_PARTNER_TIER_PRODUCT = "/api/lcuser/rewards_brand_list";
  static const String QR_CODE = "/api/lcuser/getRewardData";




  ///Scan Receipt
  static const String SCAN_RECEIPT = "/api/lcuser/scanReceipt";
  static const String SCAN_HISTORY = "/api/lcuser/brandWisePoints";


  ///Offer list
  static const String OFFER_LIST = "/api/lcuser/offer_list";

}
