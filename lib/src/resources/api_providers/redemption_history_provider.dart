import 'package:dio/dio.dart';
import 'package:lets_collect/src/model/redemption_history/redemption_history.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';

class RedemptionHistoryDataProvider {
  Future<StateModel?> getRedemptionData() async {
    try{
      final response = await ObjectFactory().apiClient.getRedemptionHistoryResponse();
      print(response.toString());

      if (response.statusCode == 200) {
        return StateModel<RedemptionHistoryResponse>.success(
            RedemptionHistoryResponse.fromJson(response.data));
      } else {
        return null;
      }    }on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null && e.response!.statusCode == 500) {
        // print(e.response!.statusCode == 500);
        print("Error: ${e.error.toString()}");
        print("Error msg: ${e.message}");
        print("Error type: ${e.type}");
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