
import 'package:lets_collect/src/utils/data/prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../client/api_client.dart';

/// it is a hub that connecting pref,repo,client
/// used to reduce imports in pages
class ObjectFactory {
  static final _objectFactory = ObjectFactory._internal();

  ObjectFactory._internal();

  factory ObjectFactory() => _objectFactory;

  ///Initialisation of Objects
  final Prefs _prefs = Prefs();
  final ApiClient _apiClient = ApiClient();


  ///
  /// Getters of Objects
  ///
  ApiClient get apiClient => _apiClient;

  Prefs get prefs => _prefs;


  ///
  /// Setters of Objects
  ///
  void setPrefs(SharedPreferences sharedPreferences) {
    _prefs.sharedPreferences = sharedPreferences;
  }
}
