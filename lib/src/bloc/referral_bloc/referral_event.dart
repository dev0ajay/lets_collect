part of 'referral_bloc.dart';

abstract class ReferralEvent extends Equatable {
  const ReferralEvent();
}

/// Referral List

class GetReferralListEvent extends ReferralEvent{
  @override
  List<Object?> get props => [];

}

/// Referral Friend

class GetReferralFriendEvent extends ReferralEvent{
  final ReferralFriendRequest referralFriendRequest;
  const GetReferralFriendEvent({required this.referralFriendRequest});
  @override
  List<Object?> get props => [referralFriendRequest];

}

/// Referral Code Update

class GetReferralCodeUpdateEvent extends ReferralEvent{
  final ReferralCodeUpdateRequest referralCodeUpdateRequest;
  const GetReferralCodeUpdateEvent({required this.referralCodeUpdateRequest});
  @override
  List<Object?> get props => [referralCodeUpdateRequest];

}

