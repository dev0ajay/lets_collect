import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:lets_collect/src/model/home/home_page_response.dart';
import '../../model/state_model.dart';
import '../../utils/data/object_factory.dart';

class HomeDataProvider {
  Future<StateModel?> getHomeData() async {
    final response = await ObjectFactory().apiClient.getHomeData();

      print(response.toString());

    if(response!=null){
      if (response.statusCode == 200) {
        return StateModel<HomeResponse>.success(
            HomeResponse.fromJson(response.data));
      } else {
        return null;
      }}
    else{
      return null;
    }
  }

}