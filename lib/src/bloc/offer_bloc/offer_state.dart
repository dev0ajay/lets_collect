part of 'offer_bloc.dart';

abstract class OfferState extends Equatable {
  const OfferState();
}

class OfferInitial extends OfferState {
  @override
  List<Object> get props => [];
}


class OfferLoading extends OfferState {
  @override
  List<Object> get props => [];
}


class OfferLoaded extends OfferState {
  final OfferListRequestResponse offerListRequestResponse;
  const OfferLoaded({required this.offerListRequestResponse});
  @override
  List<Object> get props => [offerListRequestResponse];
}

class OfferErrorState extends OfferState {
  final String errorMsg;
  const OfferErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}