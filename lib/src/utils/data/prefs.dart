import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// shared preference storage
class Prefs {
  JsonCodec codec = new JsonCodec();
  SharedPreferences? _sharedPreferences;

  static const String? _IS_USER_LOADED = "is_user_loaded";
  static const String? _IS_HOME_1_DATA_LOADED = "is_home_1_data_loaded";
  static const String? _IS_HOME_2_DATA_LOADED = "is_home_2_data_loaded";
  static const String? _AUTH_TOKEN = "auth_token";
  static const String? _USER_ID = "user_id";
  static const String? _LAYOUT_ID = "layout_id";
  static const String? _COMPARE_CATEGORY_ID = "compare_category_id";
  static const String? _CUSTOMER_NOTE = "customer_note";
  static const String? _SORT_ID = "sort_id";
  static const String? _FILTER_CATEGORY_ID = "filter_category_id";
  static const String? _FCM_TOKEN = "fcm_token";
  static const String? _USER_DATA = "user_data";
  static const String? _REFERRAL_DATA = "referral_data";
  static const String? _HELP_CENTER_DATA = "help_center_data";

  static const String? _IS_LOGGED_IN = "is_logged_in";
  static const String? _IS_SHOW_BIRTHDAY_WISH = "is_show_birthday_wish";
  static const String? _IS_SHOW_VOTING = "is_show_voting";
  static const String? _IS_MOB_NUM_VERIFIED = "is_mob_num_verified";
  static const String? _IS_REFERRAL_LOADED = "is_referral_loaded";
  static const String? _IS_HELP_CENTER_LOADED = "is_help_center_loaded";

  static const String? REQUESTED_FLAT_ID = "requested_flat_id";
  static const String? _RECENT_SEARCH_LIST = "recent_search_list";
  static const String? _CATEGORY_LIST = "category_list";
  static const String? _SELECTED_FILTER_LIST = "selected_filter_list";
  static const String? _SELECTED_COMPARE_LIST = "selected_compare_list";
  static const String? _PRODUCT_LIST_HOME_1 = "product_list_home_1";
  static const String? _PRODUCT_LIST_HOME_2 = "product_list_home_2";

  static const String? _ADDRESS_LIST = "address_list";
  static const String? _STATE_LIST = "state_list";
  static const String? _BUY_NOW_ITEM = "buy_now_item";
  static const String? _REMOVED_CART_PRODUCT_LIST = "removed_cart_product_list";
  static const String? _ADD_TO_CART_PRODUCT_LIST = "add_to_cart_product_list";
  static const String? _ADD_TO_WISH_LIST = "add_to_wish_list";
  static const String? _REMOVE_FROM_WISH_LIST = "remove_from_wish_list";
  static const String? _ORDER_CANCELED_LIST = "order_canceled_list";
  static const String? _NOTIFY_ME_LIST = "notify_me_list";
  static const String? _REMOVED_NOTIFY_ME_LIST = "removed_notify_me_list";

  Prefs();

  set sharedPreferences(SharedPreferences value) {
    _sharedPreferences = value;
  }

  ///saving  the auth token as a String
  void setAuthToken({String? token}) {
    _sharedPreferences!.setString(_AUTH_TOKEN!, "Bearer " + token!);
  }

  ///get method  for auth token
  String? getAuthToken() => _sharedPreferences?.getString(_AUTH_TOKEN!);

  ///saving  the auth token as a String
  void setUserId({String? userId}) {
    _sharedPreferences!.setString(_USER_ID!, userId!);
  }

  ///get method  for auth token
  String? getUserId() => _sharedPreferences!.getString(_USER_ID!);

  ///saving  layout id
  void saveLayoutId({String? layoutId}) {
    _sharedPreferences!.setString(_LAYOUT_ID!, layoutId!);
  }

  ///get method  layout id
  String? getLayoutId() => _sharedPreferences!.getString(_LAYOUT_ID!);

  ///saving  layout id
  void saveCompareCategoryId({String? categoryId}) {
    _sharedPreferences!.setString(_COMPARE_CATEGORY_ID!, categoryId!);
  }

  ///get method  for auth token
  String? getCompareCategoryId() =>
      _sharedPreferences!.getString(_COMPARE_CATEGORY_ID!);

  ///saving  layout id
  void saveCustomerNote({String? customerNote}) {
    _sharedPreferences!.setString(_CUSTOMER_NOTE!, customerNote!);
  }

  ///get method  for auth token
  String? getCustomerNote() => _sharedPreferences!.getString(_CUSTOMER_NOTE!);

  ///saving  layout id
  void saveSortId({String? sortId}) {
    _sharedPreferences!.setString(_SORT_ID!, sortId!);
  }

  ///get method  for auth token
  String? getSortId() => _sharedPreferences!.getString(_SORT_ID!);

  ///saving  layout id
  void saveFilterCategoryId({String? categoryId}) {
    _sharedPreferences!.setString(_FILTER_CATEGORY_ID!, categoryId!);
  }

  ///get method  for auth token
  String? getFilterCategoryId() =>
      _sharedPreferences!.getString(_FILTER_CATEGORY_ID!);

  ///saving  the auth token as a String
  void setFcmToken({String? token}) async {
    await _sharedPreferences!.setString(_FCM_TOKEN!, token!);
  }

  ///get method  for auth token
  String? getFcmToken() => _sharedPreferences!.getString(_FCM_TOKEN!);

  ///after login set isLoggedIn true
  ///before logout set isLoggedIn false
  void setIsLoggedIn(bool status) {
    _sharedPreferences!.setBool(_IS_LOGGED_IN!, status);
  }

  ///checking that is logged in or not
  bool? isLoggedIn() => _sharedPreferences!.getBool(_IS_LOGGED_IN!) != null &&
      _sharedPreferences!.getBool(_IS_LOGGED_IN!) == true
      ? true
      : false;

  void setShowBirthdayWish(bool status) {
    _sharedPreferences!.setBool(_IS_SHOW_BIRTHDAY_WISH!, status);
  }

  ///checking that is logged in or not
  bool? isShowBirthdayWish() =>
      _sharedPreferences!.getBool(_IS_SHOW_BIRTHDAY_WISH!) != null &&
          _sharedPreferences!.getBool(_IS_SHOW_BIRTHDAY_WISH!) == true
          ? true
          : false;

  void setShowVoting(bool status) {
    _sharedPreferences!.setBool(_IS_SHOW_VOTING!, status);
  }

  ///checking that is logged in or not
  bool? isShowVoting() =>
      _sharedPreferences!.getBool(_IS_SHOW_VOTING!) != null &&
          _sharedPreferences!.getBool(_IS_SHOW_VOTING!) == true
          ? true
          : false;

  void setMobNotNumVerified(bool status) {
    _sharedPreferences!.setBool(_IS_MOB_NUM_VERIFIED!, status);
  }

  ///checking that is logged in or not
  bool? isMobNotNumVerified() =>
      _sharedPreferences!.getBool(_IS_MOB_NUM_VERIFIED!) != null &&
          _sharedPreferences!.getBool(_IS_MOB_NUM_VERIFIED!) == true
          ? true
          : false;

  void setIsReferralLoaded(bool status) {
    _sharedPreferences!.setBool(_IS_REFERRAL_LOADED!, status);
  }

  ///checking that is logged in or not
  bool? isReferralLoaded() =>
      _sharedPreferences!.getBool(_IS_REFERRAL_LOADED!) != null &&
          _sharedPreferences!.getBool(_IS_REFERRAL_LOADED!) == true
          ? true
          : false;

  void setIsHelpCenterLoaded(bool status) {
    _sharedPreferences!.setBool(_IS_HELP_CENTER_LOADED!, status);
  }

  ///checking that is logged in or not
  bool? isHelpCenterLoaded() =>
      _sharedPreferences!.getBool(_IS_HELP_CENTER_LOADED!) != null &&
          _sharedPreferences!.getBool(_IS_HELP_CENTER_LOADED!) == true
          ? true
          : false;

  /// for clearing the data in preference
  void clearPrefs() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  void setIsUserLoaded(bool status) {
    _sharedPreferences!.setBool(_IS_USER_LOADED!, status);
  }

  /// checking data in home layout 1 is available or not
  bool isUserLoaded() =>
      _sharedPreferences!.getBool(_IS_USER_LOADED!) != null &&
          _sharedPreferences!.getBool(_IS_USER_LOADED!) == true
          ? true
          : false;

  void setIsHome1DataLoaded(bool status) {
    _sharedPreferences!.setBool(_IS_HOME_1_DATA_LOADED!, status);
  }

  /// checking data in home layout 1 is available or not
  bool isHome1DataLoaded() =>
      _sharedPreferences!.getBool(_IS_HOME_1_DATA_LOADED!) != null &&
          _sharedPreferences!.getBool(_IS_HOME_1_DATA_LOADED!) == true
          ? true
          : false;

  void setIsHome2DataLoaded(bool status) {
    _sharedPreferences!.setBool(_IS_HOME_2_DATA_LOADED!, status);
  }

  /// checking data in home layout 2 is available or not
  bool isHome2DataLoaded() =>
      _sharedPreferences!.getBool(_IS_HOME_2_DATA_LOADED!) != null &&
          _sharedPreferences!.getBool(_IS_HOME_2_DATA_LOADED!) == true
          ? true
          : false;

  ///  save user data
  // void saveUserData(LoginWithEmailResponse result) {
  //   String jsonString = jsonEncode(result);
  //   _sharedPreferences!.setString(_USER_DATA!, jsonString);
  // }

  /// get user data
  // LoginWithEmailResponse? getUserData() {
  //   Map<String, dynamic>? resultMap =
  //   jsonDecode(_sharedPreferences!.getString(_USER_DATA!)!);
  //   var result = new LoginWithEmailResponse.fromJson(resultMap!);
  //   return result;
  // }

  ///  referral data
  // void saveReferralContent(ReferralScreenResponse result) {
  //   String jsonString = jsonEncode(result);
  //   _sharedPreferences!.setString(_REFERRAL_DATA!, jsonString);
  // }

  /// get referral data
  // ReferralScreenResponse getReferralContent() {
  //   Map<String, dynamic>? resultMap =
  //   jsonDecode(_sharedPreferences!.getString(_REFERRAL_DATA!)!);
  //   var result = new ReferralScreenResponse.fromJson(resultMap!);
  //   return result;
  // }

  // ///  help center data
  // void saveHelpCenterDetails(HelpCenterDetails result) {
  //   String jsonString = jsonEncode(result);
  //   _sharedPreferences!.setString(_HELP_CENTER_DATA!, jsonString);
  // }

  /// get referral data
  // HelpCenterDetails getHelpCenterDetails() {
  //   Map<String, dynamic>? resultMap =
  //   jsonDecode(_sharedPreferences!.getString(_HELP_CENTER_DATA!)!);
  //   var result = new HelpCenterDetails.fromJson(resultMap!);
  //   return result;
  // }

  // ///saving  the recent search list
  // void saveRecentSearch({List<String>? searchList}) {
  //   _sharedPreferences!.setStringList(_RECENT_SEARCH_LIST!, searchList!);
  // }

  ///get method  recent search list
  List<String>? getRecentSearchList() =>
      _sharedPreferences!.getStringList(_RECENT_SEARCH_LIST!);

  ///saving the recently added product id in cart list
  void saveCartProductIdList({List<String>? productIdList}) {
    _sharedPreferences!
        .setStringList(_ADD_TO_CART_PRODUCT_LIST!, productIdList!);
  }

  /// get the recently added product id in cart list
  List<String>? getCartProductIdList() =>
      _sharedPreferences!.getStringList(_ADD_TO_CART_PRODUCT_LIST!);

  ///saving the recently added product id in cart list
  void saveRemovedCartProductIdList({List<String>? productIdList}) {
    _sharedPreferences!
        .setStringList(_REMOVED_CART_PRODUCT_LIST!, productIdList!);
  }

  /// get the recently added product id in cart list
  List<String>? getRemovedCartProductIdList() =>
      _sharedPreferences!.getStringList(_REMOVED_CART_PRODUCT_LIST!);

  ///saving the recently added product id in wish list
  void saveWishListProductId({required List<String> productIdList}) {
    _sharedPreferences!.setStringList(_ADD_TO_WISH_LIST!, productIdList);
  }

  /// get the recently added product id in wish list
  List<String>? getWishListProductId() =>
      _sharedPreferences!.getStringList(_ADD_TO_WISH_LIST!);

  ///saving the recently removed product id in wish list
  void saveRemovedWishListProductId({required List<String> productIdList}) {
    _sharedPreferences!.setStringList(_REMOVE_FROM_WISH_LIST!, productIdList);
  }

  /// get the recently removed product id in wish list
  List<String>? getRemovedWishListProductId() =>
      _sharedPreferences!.getStringList(_REMOVE_FROM_WISH_LIST!);

  ///saving the recently order canceled
  void saveCanceledOrderList({required List<String> orderIdList}) {
    _sharedPreferences!.setStringList(_ORDER_CANCELED_LIST!, orderIdList);
  }

  /// get the recently removed product id in wish list
  List<String>? getCanceledOrderList() =>
      _sharedPreferences!.getStringList(_ORDER_CANCELED_LIST!);

  ///saving the recently notified product id list
  void saveNotifiedProductList({required List<String> productIdList}) {
    _sharedPreferences!.setStringList(_NOTIFY_ME_LIST!, productIdList);
  }

  /// get the recently notified product id list
  List<String>? getNotifiedProductList() =>
      _sharedPreferences!.getStringList(_NOTIFY_ME_LIST!);

  ///saving the recently removed notified product id list
  void saveRemovedNotifiedProductList({required List<String> productIdList}) {
    _sharedPreferences!.setStringList(_REMOVED_NOTIFY_ME_LIST!, productIdList);
  }

  /// get the recently removed notified product id list
  List<String>? getRemovedNotifiedProductList() =>
      _sharedPreferences!.getStringList(_REMOVED_NOTIFY_ME_LIST!);

  ///saving the filter list
  void saveFilterList({required List<String> filterList}) {
    _sharedPreferences!.setStringList(_SELECTED_FILTER_LIST!, filterList);
  }

  /// get the filter list
  List<String>? getFilterList() =>
      _sharedPreferences!.getStringList(_SELECTED_FILTER_LIST!);

  ///saving the filter list
  void saveCompareList({required List<String> compareList}) {
    _sharedPreferences!.setStringList(_SELECTED_COMPARE_LIST!, compareList);
  }

  /// get the filter list
  List<String>? getCompareList() =>
      _sharedPreferences!.getStringList(_SELECTED_COMPARE_LIST!);

  ///  save categories data
  // void saveAllCategories(CategoryResponse result) {
  //   String jsonString = jsonEncode(result);
  //   _sharedPreferences!.setString(_CATEGORY_LIST!, jsonString);
  // }

  // CategoryResponse? getAllCategories() {
  //   Map<String, dynamic>? resultMap =
  //   jsonDecode(_sharedPreferences!.getString(_CATEGORY_LIST!)!);
  //   var result = new CategoryResponse.fromJson(resultMap!);
  //   return result;
  // }







  /// save States list
  // void saveStateList(StateResponse result) {
  //   String jsonString = jsonEncode(result);
  //   _sharedPreferences!.setString(_STATE_LIST!, jsonString);
  // }

  // StateResponse? getStateList() {
  //   Map<String, dynamic>? resultMap =
  //   jsonDecode(_sharedPreferences!.getString(_STATE_LIST!)!);
  //   var result = new StateResponse.fromJson(resultMap!);
  //   return result;
  // }


}
