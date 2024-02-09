part of 'reward_tier_bloc.dart';

abstract class RewardTierEvent extends Equatable {
  const RewardTierEvent();
}


class RewardTierRequestEvent extends RewardTierEvent {
  final RewardTierRequest rewardTierRequest;
  const RewardTierRequestEvent({required this.rewardTierRequest});
  @override
  List<Object?> get props => [rewardTierRequest];

}