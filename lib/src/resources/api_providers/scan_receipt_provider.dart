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
      // 404
      final response =
      await ObjectFactory().apiClient.uploadReceipt(data);
      if (response != null) {
        print(response.toString());
        if (response.statusCode == 200) {
          return StateModel<ScanReceiptRequestResponse>.success(
              ScanReceiptRequestResponse.fromJson(response.data));
        } else {

        }
      }
      print(response.toString());
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        return StateModel.error(e.message);
        // return response!;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
      // return e;
    }
  }


///Scan Receipt history
  Future<StateModel?> showScanHistory(ScanReceiptHistoryRequest scanReceiptHistoryRequest) async {
    try {
      // 404
      final response =
      await ObjectFactory().apiClient.showScanHistory(scanReceiptHistoryRequest);
      if (response != null) {
        print(response.toString());
        if (response.statusCode == 200) {
          return StateModel<ScanReceiptHistoryResponse>.success(
              ScanReceiptHistoryResponse.fromJson(response.data));
        } else {
          // if (response.statusCode == 200) {}
        }
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
        return StateModel.error("Oops Something went wrong!");
        // return response!;
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
      // return e;
    }
  }



}