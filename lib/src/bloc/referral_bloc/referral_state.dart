part of 'referral_bloc.dart';

abstract class ReferralState extends Equatable {
  const ReferralState();
}

/// Referral List

class ReferralListInitial extends ReferralState {
  @override
  List<Object> get props => [];
}

class ReferralListLoading extends ReferralState {
  @override
  List<Object> get props => [];
}

class ReferralListLoaded extends ReferralState {
  final ReferralListResponse referralListResponse;
  const ReferralListLoaded({required this.referralListResponse});
  @override
  List<Object> get props => [];
}

class ReferralListError extends ReferralState{
  final String errorMsg;
  const ReferralListError({required this.errorMsg});
  @override
  List<Object?> get props => [];
}

/// Referral Friend

class ReferralFriendInitial extends ReferralState {
  @override
  List<Object> get props => [];
}

class ReferralFriendLoading extends ReferralState {
  @override
  List<Object> get props => [];
}

class ReferralFriendLoaded extends ReferralState {
  final ReferralFriendRequestResponse referralFriendRequestResponse;
  const ReferralFriendLoaded({required this.referralFriendRequestResponse});
  @override
  List<Object> get props => [];
}

class ReferralFriendError extends ReferralState {
  final String errorMsg;
  const ReferralFriendError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}


/// Referral Code Update

class ReferralCodeUpdateInitial extends ReferralState {
  @override
  List<Object> get props => [];
}

class ReferralCodeUpdateLoading extends ReferralState {
  @override
  List<Object> get props => [];
}

class ReferralCodeUpdateLoaded extends ReferralState {
  final ReferralCodeUpdateRequestResponse referralCodeUpdateRequestResponse;
  const ReferralCodeUpdateLoaded({required this.referralCodeUpdateRequestResponse});

  @override
  List<Object> get props => [];
}

class ReferralCodeUpdateError extends ReferralState {
  final String errorMsg;
  const ReferralCodeUpdateError({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}
