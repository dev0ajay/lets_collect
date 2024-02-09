part of 'scan_bloc.dart';

abstract class ScanEvent extends Equatable {
  const ScanEvent();
}

///Scan Receipt
class ScanReceiptEvent extends ScanEvent{
  final FormData data;
  const ScanReceiptEvent({required this.data});
  @override
  List<Object?> get props => [data];
}



///Scan Receipt History
class ScanReceiptHistoryEvent extends ScanEvent{
  final ScanReceiptHistoryRequest scanReceiptHistoryRequest;
  const ScanReceiptHistoryEvent({required this.scanReceiptHistoryRequest});
  @override
  List<Object?> get props => [scanReceiptHistoryRequest];
}

