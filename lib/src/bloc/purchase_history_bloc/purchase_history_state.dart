part of 'purchase_history_bloc.dart';

@immutable
abstract class PurchaseHistoryState extends Equatable{
  const PurchaseHistoryState();
}

class PurchaseHistoryInitial extends PurchaseHistoryState {
  @override
  List<Object?> get props => [];
}

class PurchaseHistoryLoading extends PurchaseHistoryState {
  @override
  List<Object?> get props => [];
}

class PurchaseHistoryLoaded extends PurchaseHistoryState {
  final PurchaseHistoryResponse purchaseHistoryResponse;
  const PurchaseHistoryLoaded({required this.purchaseHistoryResponse});
  @override
  List<Object?> get props => [];
}

/// Purchase History Details

class PurchaseHistoryDetailsInitial extends PurchaseHistoryState{
  @override
  List<Object?> get props => [];
}

class PurchaseHistoryDetailsLoading extends PurchaseHistoryState{
  @override
  List<Object?> get props => [];
}

class PurchaseHistoryDetailsLoaded extends PurchaseHistoryState{
  final PurchaseHistoryDetailsResponse purchaseHistoryDetailsResponse;
  const PurchaseHistoryDetailsLoaded({required this.purchaseHistoryDetailsResponse});
  @override
  List<Object?> get props => [purchaseHistoryDetailsResponse];
}

