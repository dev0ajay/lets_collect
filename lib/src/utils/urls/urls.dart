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
  static const String  APPLE_SIGNIN= "/api/apple_login";
  static const String  FACEBOOK_SIGNIN= "/api/facebook_login";



  ///Search Category
  static const String SEARCH_DEPARTMENT = "/api/lcuser/department_search";
  ///Search Brand
  static const String SEARCH_BBRAND = "/api/lcuser/brand_search";

  ///Home Screen
  static const String HOME_DATA = "/api/lcuser/customer_home";

  ///Notification
  static const String NOTIFICATION = "/api/lcuser/list_notifications";


  ///Profile Screen
  static const String TERMS_AND_CONDITIONS = "/api/lcuser/terms_and_conditions";
  static const String PRIVACY_POLICIES = "/api/lcuser/privacy_policy";
  static const String PURCHASE_HISTORY = "/api/lcuser/purchase_history";
  static const String PURCHASE_HISTORY_DETAILS = "/api/lcuser/purchase_history_details";
  static const String POINT_TRACKER_FILTER = "/api/lcuser/supermarket_ist";
  static const String MY_PROFILE_DATA = "/api/lcuser/getprofile";
  static const String CONTACT_US = "/api/lcuser/send_support";
  static const String HOW_TO_REDEEM_MY_POINTS = "/api/lcuser/how_to_redeem_mypoints";
  static const String POINT_CALCULATIONS = "/api/lcuser/point_calculations";
  static const String DELETE_ACCOUNT = "/api/delete_customer_account";
  static const String MY_EDIT_PROFILE_DATA = "/api/lcuser/updateProfile";
  static const String REDEMPTION_HISTORY = "/api/lcuser/redemption_history";
  static const String REFERRAL_LIST = "/api/lcuser/referral_list";
  static const String REFERRAL_FRIEND = "/api/lcuser/refer_friend";
  static const String REFERRAL_CODE_UPDATE = "/api/lcuser/referral_code_update";
  static const String CHANGE_PASSWORD = "/api/lcadmin/change_password";
  static const String LANGUAGE_SELECTION = "/api/lcadmin/update_language";




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


  ///Point Tracker
  static const String POINT_TRACKER = "/api/lcuser/point_history";
  static const String POINT_TRACKER_DETAILS = "/api/lcuser/point_history_details";


}
