part of 'purchase_history_bloc.dart';

@immutable
abstract class PurchaseHistoryEvent extends Equatable{
  const PurchaseHistoryEvent();
}

class GetPurchaseHistory extends PurchaseHistoryEvent{
  final PurchaseHistoryRequest purchaseHistoryRequest;
  const GetPurchaseHistory({required this.purchaseHistoryRequest});
  @override
  List<Object?> get props => [];

}



// class GetPurchaseHistoryDetails extends PurchaseHistoryEvent{
//   final PurchaseHistoryDetailsRequest purchaseHistoryDetailsRequest;
//   const GetPurchaseHistoryDetails({required this.purchaseHistoryDetailsRequest});
//   @override
//   List<Object?> get props => [];
//
// }
