part of 'redeem_bloc.dart';

abstract class RedeemEvent extends Equatable {
  const RedeemEvent();
}
class GetQrCodeUrlEvent extends RedeemEvent {
  final QrCodeUrlRequest qrCodeUrlRequest;
  const GetQrCodeUrlEvent({required this.qrCodeUrlRequest});
  @override
  List<Object?> get props => [];
}