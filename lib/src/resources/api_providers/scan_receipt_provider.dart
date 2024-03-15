import 'package:dio/dio.dart';
import 'package:lets_collect/src/model/scan_receipt/scan_receipt_history_request.dart';
import 'package:lets_collect/src/model/scan_receipt/scan_receipt_history_response.dart';
import 'package:lets_collect/src/model/scan_receipt/scan_reciept_request_response.dart';
import '../../model/state_model.dart';
import '../../utils/data/object_factory.dart';

class ScanReceiptApiProvider {

///Scan Receipt
  Future<StateModel?> uploadReceipt(FormData data) async {
    try {
      final response =
      await ObjectFactory().apiClient.uploadReceipt(data);
      print(response.toString());
      if (response.statusCode == 200) {
        return StateModel<ScanReceiptRequestResponse>.success(
            ScanReceiptRequestResponse.fromJson(response.data));
      } else {

      }
      print(response.toString());
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null && e.response!.statusCode == 500) {
        // print(e.response!.statusCode == 500);
        print("Error: ${e.error.toString()}");
        print("Error msg: ${e.message}");
        print("Error type: ${e.type}");
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
        return StateModel.error("Oops! It looks like the server isn't responding! Please try again later");
        // return response!;
      } else if(e.response != null && e.response!.statusCode == 408){
        return StateModel.error("Hello there! It seems like your request took longer than expected to process. We apologize for the inconvenience. Please try again later or reach out to our support team for assistance. Thank you for your patience!");
        // Something happened in setting up or sending the request that triggered an Error
      }else if(e.response != null && e.response!.statusCode == 404){
        return StateModel.error("Oops! It looks like the server isn't responding! Please try again later");
        // Something happened in setting up or sending the request that triggered an Error
      }

      // return e;
    }
    return null;
  }


///Scan Receipt history
  Future<StateModel?> showScanHistory(ScanReceiptHistoryRequest scanReceiptHistoryRequest) async {
    try {
      // 404
      final response =
      await ObjectFactory().apiClient.showScanHistory(scanReceiptHistoryRequest);
      print(response.toString());
      if (response.statusCode == 200) {
        return StateModel<ScanReceiptHistoryResponse>.success(
            ScanReceiptHistoryResponse.fromJson(response.data));
      } else {
        // if (response.statusCode == 200) {}
      }
        } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null && e.response!.statusCode == 500) {
        // print(e.response!.statusCode == 500);
        print("Error: ${e.error.toString()}");
        print("Error msg: ${e.message}");
        print("Error type: ${e.type}");
        // print(e.response!.headers);
        // print(e.response!.requestOptions);
        return StateModel.error("Oops! It looks like the server isn't responding! Please try again later");
        // return response!;
      } else if(e.response != null && e.response!.statusCode == 408){
        return StateModel.error("Hello there! It seems like your request took longer than expected to process. We apologize for the inconvenience. Please try again later or reach out to our support team for assistance. Thank you for your patience!");
        // Something happened in setting up or sending the request that triggered an Error
      }else if(e.response != null && e.response!.statusCode == 404){
        return StateModel.error("Oops! It looks like the server isn't responding! Please try again later");
        // Something happened in setting up or sending the request that triggered an Error
      }

      // return e;
    }
    return null;
  }



}