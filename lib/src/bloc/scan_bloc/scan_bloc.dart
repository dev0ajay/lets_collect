
import 'package:bloc/bloc.dart';
import 'package:dio/src/form_data.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/scan_receipt/scan_receipt_history_request.dart';
import 'package:lets_collect/src/model/scan_receipt/scan_receipt_history_response.dart';
import 'package:lets_collect/src/model/scan_receipt/scan_reciept_request_response.dart';
import 'package:lets_collect/src/model/state_model.dart';
import '../../resources/api_providers/scan_receipt_provider.dart';

part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final ScanReceiptApiProvider scanReceiptApiProvider;
  ScanBloc({required this.scanReceiptApiProvider}) : super(ScanInitial()) {
    on<ScanReceiptEvent>((event, emit) async{
      emit(ScanLoading());
      final StateModel? stateModel = await scanReceiptApiProvider.uploadReceipt(event.data);
      if(stateModel is SuccessState) {
        emit(ScanLoaded(scanReceiptRequestResponse: stateModel.value));
      }
      if(stateModel is ErrorState) {
        emit(ScanError(errorMsg: stateModel.msg));
      }
    });
    on<ScanReceiptHistoryEvent>((event, emit) async{
      emit(ScanReceiptHistoryLoading());
      final StateModel? stateModel = await scanReceiptApiProvider.showScanHistory(event.scanReceiptHistoryRequest);
      if(stateModel is SuccessState) {
        emit(ScanReceiptHistoryLoaded(scanReceiptHistoryResponse: stateModel.value));
      }
      if(stateModel is ErrorState) {
        emit(ScanReceiptHistoryError(errorMsg: stateModel.msg));
      }
    });
  }
}
