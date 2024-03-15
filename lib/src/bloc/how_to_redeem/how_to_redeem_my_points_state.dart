part of 'how_to_redeem_my_points_bloc.dart';

abstract class HowToRedeemMyPointsState extends Equatable {
  const HowToRedeemMyPointsState();
}

class HowToRedeemMyPointsInitial extends HowToRedeemMyPointsState {
  @override
  List<Object> get props => [];
}

class HowToRedeemMyPointsLoading extends HowToRedeemMyPointsState {
  @override
  List<Object> get props => [];
}

class HowToRedeemMyPointsLoaded extends HowToRedeemMyPointsState {
  final HowToRedeemMyPointsResponse howToRedeemMyPointsResponse;
  const HowToRedeemMyPointsLoaded({required this.howToRedeemMyPointsResponse});
  @override
  List<Object> get props => [howToRedeemMyPointsResponse];
}