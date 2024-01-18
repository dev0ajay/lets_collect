part of 'privacy_policies_bloc.dart';

abstract class PrivacyPoliciesState extends Equatable {
  const PrivacyPoliciesState();
}

class PrivacyPoliciesInitial extends PrivacyPoliciesState {
  @override
  List<Object> get props => [];
}

class PrivacyPoliciesLaoding extends PrivacyPoliciesState {
  @override
  List<Object> get props => [];
}
class PrivacyPoliciesLoaded extends PrivacyPoliciesState {
  final PrivacyPoliciesResponse privacyPoliciesResponse;
  const PrivacyPoliciesLoaded({required this.privacyPoliciesResponse});
  @override
  List<Object> get props => [privacyPoliciesResponse];
}