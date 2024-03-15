part of 'how_to_redeem_my_points_bloc.dart';

abstract class HowToRedeemMyPointsEvent extends Equatable {
  const HowToRedeemMyPointsEvent();
}

class GetHowToRedeemMyPointsEvent extends HowToRedeemMyPointsEvent{
  @override
  List<Object?> get props =>[];
}