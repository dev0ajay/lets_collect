part of 'offer_bloc.dart';

abstract class OfferEvent extends Equatable {
  const OfferEvent();
}

class GetOfferListEvent extends OfferEvent {
  final OfferListRequest offerListRequest;
  const GetOfferListEvent({required this.offerListRequest});
  @override
  List<Object?> get props => [offerListRequest];

}