import 'package:lets_collect/src/model/point_tracker/point_tracker_details_request.dart';
import 'package:lets_collect/src/model/point_tracker/point_tracker_details_response.dart';
import 'package:lets_collect/src/model/point_tracker/point_tracker_request.dart';
import 'package:lets_collect/src/model/point_tracker/point_tracker_response.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';

class PointTrackerProvider {
  Future<StateModel?> pointTrackerRequest(
      PointTrackerRequest pointTrackerRequest) async {
    final response = await ObjectFactory()
        .apiClient
        .pointTrackerRequest(pointTrackerRequest);
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<PointTrackerRequestResponse>.success(
          PointTrackerRequestResponse.fromJson(response.data));
    } else {
      return null;
    }
    }

  Future<StateModel?> pointTrackerDetailsRequest(
      PointTrackerDetailsRequest pointTrackerDetailsRequest) async {
    final response = await ObjectFactory()
        .apiClient
        .pointTrackerDetailsRequest(pointTrackerDetailsRequest);
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<PointTrackerDetailsRequestResponse>.success(
          PointTrackerDetailsRequestResponse.fromJson(response.data));
    }
    else {
      return null;
    }
    }





}
