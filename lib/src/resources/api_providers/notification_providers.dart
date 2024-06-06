import 'package:dio/dio.dart';
import '../../model/notification/notification_response.dart';
import '../../model/state_model.dart';
import '../../utils/data/object_factory.dart';

class NotificationProvider {
  Future<StateModel?> getNotificationData() async {
    try {
      final response = await ObjectFactory().apiClient.getNotificationData();
      if (response.statusCode == 200) {
        // print(response.toString());
        return StateModel<NotificationGetResponse>.success(
            NotificationGetResponse.fromJson(response.data));
      } else {
        return null;
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null && e.response!.statusCode == 500) {

        return StateModel.error(
            "The server isn't responding! Please try again later.");
        // return response!;
      } else if (e.response != null && e.response!.statusCode == 408) {
        return StateModel.error(
            "Hello there! It seems like your request took longer than expected to process. We apologize for the inconvenience. Please try again later or reach out to our support team for assistance. Thank you for your patience!");
        // Something happened in setting up or sending the request that triggered an Error
      }
    }
    return null;
  }
}
