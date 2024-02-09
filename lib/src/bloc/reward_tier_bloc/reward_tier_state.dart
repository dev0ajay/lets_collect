part of 'reward_tier_bloc.dart';

abstract class RewardTierState extends Equatable {
  const RewardTierState();
}

class RewardTierInitial extends RewardTierState {
  @override
  List<Object> get props => [];
}

class RewardTierLoading extends RewardTierState {
  @override
  List<Object> get props => [];
}
class RewardTierLoaded extends RewardTierState {
  final RewardTierRequestResponse rewardTierRequestResponse;
  const RewardTierLoaded({required this.rewardTierRequestResponse});
  @override
  List<Object> get props => [rewardTierRequestResponse];
}

class RewardTierError extends RewardTierState {
  final String errorMsg;
  const RewardTierError({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}