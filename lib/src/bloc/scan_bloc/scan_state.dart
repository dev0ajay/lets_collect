part of 'scan_bloc.dart';

abstract class ScanState extends Equatable {
  const ScanState();
}

class ScanInitial extends ScanState {
  @override
  List<Object> get props => [];
}


class ScanLoading extends ScanState {
  @override
  List<Object> get props => [];
}

class ScanLoaded extends ScanState {
  final ScanReceiptRequestResponse scanReceiptRequestResponse;
  const ScanLoaded({required this.scanReceiptRequestResponse});
  @override
  List<Object> get props => [scanReceiptRequestResponse];
}

class ScanError extends ScanState {
  final String errorMsg;
  const ScanError({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

///Scan receipt history states
class ScanReceiptHistoryInitial extends ScanState {
  @override
  List<Object> get props => [];
}

class ScanReceiptHistoryLoading extends ScanState {
  @override
  List<Object> get props => [];
}


class ScanReceiptHistoryLoaded extends ScanState {
  final ScanReceiptHistoryResponse scanReceiptHistoryResponse;
  const ScanReceiptHistoryLoaded({required this.scanReceiptHistoryResponse});
  @override
  List<Object> get props => [scanReceiptHistoryResponse];
}

class ScanReceiptHistoryError extends ScanState {
  final String errorMsg;
  const ScanReceiptHistoryError({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}