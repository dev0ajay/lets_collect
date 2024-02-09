part of 'redeem_bloc.dart';

abstract class RedeemState extends Equatable {
  const RedeemState();
}

class RedeemInitial extends RedeemState {
  @override
  List<Object> get props => [];
}

class RedeemLoading extends RedeemState {
  @override
  List<Object> get props => [];
}

class RedeemLoaded extends RedeemState {
final QrCodeUrlRequestResponse qrCodeUrlRequestResponse;
const RedeemLoaded({required this.qrCodeUrlRequestResponse});
  @override
  List<Object> get props => [qrCodeUrlRequestResponse];
}